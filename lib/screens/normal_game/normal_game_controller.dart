import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../controllers/base_game_controller.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../models/team/team.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/routing.dart';
import '../../util/teams.dart';
import '../../util/typedef.dart';

class NormalGameController extends ValueNotifier<NormalGameState> {
  final LoggerService logger;
  final DictionaryService dictionary;
  final BackgroundImageService backgroundImage;
  final HiveService hive;
  final BaseGameController baseGame;

  final List<Team> passedTeams;
  final int pointsToWin;
  final int lengthOfRound;
  final bool useDynamicBackgrounds;

  NormalGameController({
    required this.logger,
    required this.dictionary,
    required this.backgroundImage,
    required this.hive,
    required this.baseGame,
    required this.passedTeams,
    required this.pointsToWin,
    required this.lengthOfRound,
    required this.useDynamicBackgrounds,
  }) : super(
          (
            gameState: GameState.idle,
            counter3Seconds: 0,
            playedWords: [],
            currentWord: null,
            teams: passedTeams,
            tieBreakTeams: null,
            playingTeam: passedTeams.first,
          ),
        );

  ///
  /// VARIABLES
  ///

  late NormalGameStats normalGameStats;

  ///
  /// INIT
  ///

  void init() {
    normalGameStats = NormalGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      teams: List.from(passedTeams),
      rounds: [],
      lengthOfRound: lengthOfRound,
      pointsToWin: pointsToWin,
      language: dictionary.value,
    );
  }

  ///
  /// METHODS
  ///

  /// Updates `state` with passed values
  void updateState({
    GameState? newGameState,
    int? newCounter3Seconds,
    List<PlayedWord>? newPlayedWords,
    String? newCurrentWord,
    List<Team>? newTeams,
    List<Team>? newTieBreakTeams,
    Team? newPlayingTeam,
  }) =>
      value = (
        gameState: newGameState ?? value.gameState,
        counter3Seconds: newCounter3Seconds ?? value.counter3Seconds,
        playedWords: newPlayedWords ?? value.playedWords,
        currentWord: newCurrentWord ?? value.currentWord,
        teams: newTeams ?? value.teams,
        tieBreakTeams: newTieBreakTeams ?? value.tieBreakTeams,
        playingTeam: newPlayingTeam ?? value.playingTeam,
      );

  /// Counts down the 3 seconds before starting new round
  Future<void> start3SecondCountdown({required BuildContext context}) async {
    updateState(
      newGameState: GameState.starting,
      newCounter3Seconds: 3,
    );

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        updateState(
          newCounter3Seconds: value.counter3Seconds - 1,
        );

        /// Timer is done, start round
        if (value.counter3Seconds == 0) {
          timer.cancel();
          startRound(
            lengthOfRound: lengthOfRound,
            context: context,
          );
        }
      },
    );

    await baseGame.startAudioRecording(
      path: 'moderni_alias_normal_game_${normalGameStats.startTime.millisecondsSinceEpoch}_audio_${normalGameStats.rounds.length + 1}',
    );
    await WakelockPlus.enable();
  }

  /// Triggered when the counter finishes and round starts
  void startRound({
    required int lengthOfRound,
    required BuildContext context,
  }) {
    /// Generate `newWord`
    final newWord = dictionary.getRandomWord(
      previousWord: value.currentWord,
    );

    /// Update state for round start
    updateState(
      newPlayedWords: [],
      newGameState: GameState.playing,
      newCurrentWord: newWord,
    );

    /// Change background if enabled
    if (useDynamicBackgrounds) {
      backgroundImage.changeBackground(
        ModerniAliasImages.blurredBlue,
        isTemporary: true,
      );
    }

    /// Start time countdown
    baseGame.startTimers(
      lengthOfRound,
      useDynamicBackgrounds: useDynamicBackgrounds,
      onGameTimerFinished: () => stopGameCheckWinner(
        context: context,
      ),
    );
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameStopped() {
    updateState(
      newGameState: GameState.idle,
    );
    backgroundImage.revertBackground();
    baseGame.cancelTimers();
    WakelockPlus.disable();
  }

  /// Check if there's a winner
  /// If no winner, continue the game with the next team
  /// If winner, show the confetti screen
  void stopGameCheckWinner({required BuildContext context}) {
    gameStopped();

    /// Check if there are teams which have enough points to win the game
    final teamsWithEnoughPoints = getTeamsWithEnoughPoints(
      teams: value.teams,
      pointsToWin: pointsToWin,
    );

    /// There are no teams with enough points, continue playing the game
    if (teamsWithEnoughPoints.isEmpty) {
      continueGame(
        value.teams,
        context: context,
      );
      return;
    }

    ///
    /// There are teams which have enough points to win the game
    ///

    /// Round is not finished, continue playing the game
    final activeTeams = List<Team>.from(value.tieBreakTeams ?? value.teams);

    final isRoundNotDone = roundNotDone(
      teamsToCheck: activeTeams,
      playingTeam: value.playingTeam,
    );

    if (isRoundNotDone) {
      continueGame(
        activeTeams,
        context: context,
      );
    }

    /// Round is finished, play tie break if there are tied teams or end game
    else {
      final tiedTeams = getTiedTeams(teamsWithEnoughPoints);

      handleTieBreak(
        tiedTeams,
        context: context,
      );
    }
  }

  /// Game went into tie break, handle accordingly
  void handleTieBreak(
    List<Team> tiedTeams, {
    required BuildContext context,
  }) {
    updateState(
      newTieBreakTeams: tiedTeams,
    );

    if (tiedTeams.length > 1) {
      continueGame(
        tiedTeams,
        context: context,
        overriddenIndex: 0,
      );
    } else {
      endGame(
        context: context,
      );
    }
  }

  /// Continues tie break with proper teams
  Future<void> continueGame(
    List<Team> playingTeams, {
    required BuildContext context,
    int? overriddenIndex,
  }) async {
    /// Show sheet with scores
    await baseGame.showScoresSheet(
      teams: value.teams,
      playedWords: value.playedWords,
      backgroundImage: backgroundImage.value,
      context: context,
    );

    /// Update stats which will go in [Hive]
    await updateStatsAndUsedWords(
      gameType: GameState.idle,
    );

    final nextPlayingTeam = getNextPlayingTeam(
      teams: playingTeams,
      previousTeam: value.playingTeam,
      overriddenIndex: overriddenIndex,
    );

    /// Update state with next playing `team`
    updateState(
      newPlayingTeam: nextPlayingTeam,
    );
  }

  /// Ends game and goes to [NormalGameFinishedScreen]
  Future<void> endGame({required BuildContext context}) async {
    updateState(
      newGameState: GameState.finished,
    );

    await backgroundImage.revertBackground();
    await updateStatsAndUsedWords(
      gameType: GameState.finished,
    );
    await WakelockPlus.disable();

    openNormalGameFinished(
      context,
      teams: value.teams,
      pointsToWin: pointsToWin,
      lengthOfRound: lengthOfRound,
      playedWords: value.playedWords,
    );
  }

  void answerChosen({
    required Answer chosenAnswer,
    required BuildContext context,
  }) {
    /// Game is not running, handle tapping answer
    if (value.gameState == GameState.idle) {
      start3SecondCountdown(
        context: context,
      );
      return;
    }

    /// Game is starting, don't do anything
    if (value.gameState == GameState.starting) {
      return;
    }

    /// Game is running
    /// 1. Play proper sound
    /// 2. Add an answer to the proper team
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    baseGame.playAnswerSound(
      chosenAnswer: chosenAnswer,
    );

    /// Update relevant variables & `state`
    final newPlayingTeam = value.playingTeam.copyWith(
      points: chosenAnswer == Answer.correct ? value.playingTeam.points + 1 : value.playingTeam.points - 1,
      correctPoints: chosenAnswer == Answer.correct ? value.playingTeam.correctPoints + 1 : null,
      wrongPoints: chosenAnswer == Answer.wrong ? value.playingTeam.wrongPoints + 1 : null,
    );

    final newTeams = List<Team>.from(value.teams).map((team) => team == value.playingTeam ? newPlayingTeam : team).toList();

    updateState(
      newTeams: newTeams,
      newPlayingTeam: newPlayingTeam,
      newPlayedWords: [
        ...value.playedWords,
        if (value.currentWord != null)
          PlayedWord(
            word: value.currentWord!,
            chosenAnswer: chosenAnswer,
          ),
      ],
      newCurrentWord: dictionary.getRandomWord(
        previousWord: value.currentWord,
      ),
    );
  }

  /// Save audio file and update stats and store them in [Hive]
  /// Update `usedWords` in [Dictionary] and [Hive]
  Future<void> updateStatsAndUsedWords({required GameState gameType}) async {
    final newPlayedWords = List<PlayedWord>.from(value.playedWords);

    normalGameStats = normalGameStats.copyWith(
      teams: List.from(value.teams),
      endTime: gameType == GameState.finished ? DateTime.now() : null,
      rounds: [
        ...normalGameStats.rounds,
        Round(
          playedWords: newPlayedWords,
          playingTeam: value.playingTeam,
          audioRecording: await baseGame.saveAudioFile(),
        ),
      ],
    );

    /// Update used words in [Dictionary] and [Hive]
    await baseGame.updateUsedWords(newPlayedWords);

    /// Game finished, add new stats to [Hive]
    if (gameType == GameState.finished) {
      await hive.addNormalGameStatsToBox(
        normalGameStats: normalGameStats,
      );
    }
  }
}
