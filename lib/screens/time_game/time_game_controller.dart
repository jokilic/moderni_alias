import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../constants/sounds.dart';
import '../../controllers/base_game_controller.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../models/team/team.dart';
import '../../models/time_game_stats/time_game_stats.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/routing.dart';
import '../../util/sound.dart';
import '../../util/typedef.dart';

class TimeGameController extends ValueNotifier<TimeGameState> implements Disposable {
  final LoggerService logger;
  final DictionaryService dictionary;
  final BackgroundImageService backgroundImage;
  final HiveService hive;
  final BaseGameController baseGame;

  final List<Team> passedTeams;
  final int numberOfWords;
  final bool useDynamicBackgrounds;

  TimeGameController({
    required this.logger,
    required this.dictionary,
    required this.backgroundImage,
    required this.hive,
    required this.baseGame,
    required this.passedTeams,
    required this.numberOfWords,
    required this.useDynamicBackgrounds,
  }) : super(
          (
            gameState: GameState.idle,
            counter3Seconds: 0,
            playedWords: [],
            currentWord: null,
            teams: passedTeams,
            playingTeam: passedTeams.first,
            timeGameDuration: Duration.zero,
          ),
        );

  ///
  /// VARIABLES
  ///

  late TimeGameStats timeGameStats;

  late final AudioPlayer timeGameEndAudioPlayer;

  Timer? timer;

  ///
  /// INIT
  ///

  void init() {
    timeGameStats = TimeGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      teams: List.from(passedTeams),
      rounds: [],
      numberOfWords: numberOfWords,
      language: dictionary.value,
    );

    timeGameEndAudioPlayer = AudioPlayer()
      ..setAsset(
        ModerniAliasSounds.timeGameEnd,
        preload: false,
      );
  }

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    timer?.cancel();
    timeGameEndAudioPlayer.dispose();
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
    Team? newPlayingTeam,
    Duration? newTimeGameDuration,
  }) =>
      value = (
        gameState: newGameState ?? value.gameState,
        counter3Seconds: newCounter3Seconds ?? value.counter3Seconds,
        playedWords: newPlayedWords ?? value.playedWords,
        currentWord: newCurrentWord ?? value.currentWord,
        teams: newTeams ?? value.teams,
        playingTeam: newPlayingTeam ?? value.playingTeam,
        timeGameDuration: newTimeGameDuration ?? value.timeGameDuration,
      );

  /// Sets the variables and starts the `Timer`
  void startTimer() => timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => updateState(
          newTimeGameDuration: Duration(
            seconds: timer.tick,
          ),
        ),
      );

  /// Counts down the 3 seconds before starting new round
  Future<void> start3SecondCountdown() async {
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
          startRound();
        }
      },
    );

    await baseGame.startAudioRecording();
  }

  /// Triggered when the counter finishes and round starts
  void startRound() {
    /// Generate `newWord`
    final newWord = dictionary.getRandomWord(
      previousWord: value.currentWord,
    );

    /// Update state for round start
    updateState(
      newPlayedWords: [],
      newGameState: GameState.playing,
      newCurrentWord: newWord,
      newTimeGameDuration: Duration.zero,
    );

    /// Change background if enabled
    if (useDynamicBackgrounds) {
      backgroundImage.changeBackground(
        ModerniAliasImages.blurredBlue,
        isTemporary: true,
      );
    }

    startTimer();
  }

  /// Checks if team has guessed the selected number of words
  void checkRoundDone({required BuildContext context}) {
    /// User has guessed the proper number of words, round is done
    if (value.playingTeam.points >= numberOfWords) {
      /// Stop game
      gameStopped();

      final currentTeamIndex = value.teams.indexWhere(
        (team) => team.name == value.playingTeam.name,
      );

      /// Not every team has had it's turn, continue game
      if (currentTeamIndex < value.teams.length - 1) {
        continueGame(
          value.teams,
          context: context,
        );
      }

      /// Every team has played, end game
      else {
        endGame(
          context: context,
        );
      }
    }
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameStopped() {
    updateState(
      newGameState: GameState.idle,
    );

    backgroundImage.revertBackground();

    playSound(
      audioPlayer: timeGameEndAudioPlayer,
    );

    timer?.cancel();
  }

  /// Continues game with next team
  Future<void> continueGame(
    List<Team> playingTeams, {
    required BuildContext context,
  }) async {
    await baseGame.showTimeScoresSheet(
      context: context,
      playedWords: value.playedWords,
    );

    await updateHiveStats(
      gameType: GameState.idle,
    );

    final currentTeamIndex = playingTeams.indexWhere(
      (team) => team.name == value.playingTeam.name,
    );

    updateState(
      newPlayingTeam: value.teams[currentTeamIndex + 1],
    );
  }

  /// Goes to the confetti screen and shows info about the round
  Future<void> endGame({required BuildContext context}) async {
    updateState(
      newGameState: GameState.finished,
    );

    await backgroundImage.revertBackground();
    await updateHiveStats(gameType: GameState.finished);

    openTimeGameFinished(
      context,
      teams: value.teams,
      rounds: timeGameStats.rounds,
      playedWords: value.playedWords,
    );
  }

  ///
  /// ANSWER
  ///

  void answerChosen({
    required Answer chosenAnswer,
    required BuildContext context,
  }) {
    /// Game is not running, handle tapping answer
    if (value.gameState == GameState.idle) {
      start3SecondCountdown();
      return;
    }

    /// Game is starting, don't do anything
    if (value.gameState == GameState.starting) {
      return;
    }

    /// Game is running
    /// 1. Play proper sound
    /// 2. Add an answer to the variable
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    baseGame.playAnswerSound(
      chosenAnswer: chosenAnswer,
    );

    /// Update relevant state
    /// Update relevant state
    final newPlayingTeam = value.playingTeam.copyWith(
      points: chosenAnswer == Answer.correct ? value.playingTeam.points + 1 : null,
      correctPoints: chosenAnswer == Answer.correct ? value.playingTeam.correctPoints + 1 : null,
      wrongPoints: chosenAnswer == Answer.wrong ? value.playingTeam.wrongPoints + 1 : null,
    );

    updateState(
      newTeams: List<Team>.from(value.teams).map((team) => team == value.playingTeam ? newPlayingTeam : team).toList(),
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

    /// Update background
    if (useDynamicBackgrounds) {
      baseGame.updateTimeBackground(
        playedWords: value.playedWords,
        numberOfWords: numberOfWords,
      );
    }

    /// Check if player has guessed the selected number of words
    checkRoundDone(
      context: context,
    );
  }

  /// Save audio file and update stats and store them in [Hive]
  Future<void> updateHiveStats({required GameState gameType}) async {
    timeGameStats = timeGameStats.copyWith(
      teams: List.from(value.teams),
      endTime: gameType == GameState.finished ? DateTime.now() : null,
      rounds: [
        ...timeGameStats.rounds,
        Round(
          playedWords: List.from(value.playedWords),
          playingTeam: value.playingTeam,
          audioRecording: await baseGame.saveAudioFile(),
          durationSeconds: timer?.tick,
        ),
      ],
    );

    if (gameType == GameState.finished) {
      await hive.addTimeGameStatsToBox(
        timeGameStats: timeGameStats,
      );
    }
  }
}
