import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../constants/sounds.dart';
import '../../controllers/audio_record_controller.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../models/team/team.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/sound.dart';
import '../../util/typedef.dart';
import '../../widgets/scores/show_scores.dart';

class NormalGameController extends ValueNotifier<NormalGameState> implements Disposable {
  final LoggerService logger;
  final DictionaryService dictionary;
  final BackgroundImageService backgroundImage;
  final PathProviderService pathProvider;
  final HiveService hive;
  final AudioRecordController audioRecord;

  final List<Team> passedTeams;
  final int pointsToWin;
  final int lengthOfRound;
  final bool useDynamicBackgrounds;

  NormalGameController({
    required this.logger,
    required this.dictionary,
    required this.backgroundImage,
    required this.pathProvider,
    required this.hive,
    required this.audioRecord,
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

  late final greenSeconds = lengthOfRound * 0.6;
  late final yellowSeconds = lengthOfRound * 0.4;
  late final redSeconds = lengthOfRound * 0.15;

  late NormalGameStats normalGameStats;

  late final AudioPlayer roundEndAudioPlayer;
  late final AudioPlayer correctAudioPlayer;
  late final AudioPlayer wrongAudioPlayer;

  Timer? greenTimer;
  Timer? yellowTimer;
  Timer? redTimer;

  Timer? soundTimer;
  Timer? gameTimer;

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

    roundEndAudioPlayer = AudioPlayer()
      ..setAsset(
        ModerniAliasSounds.timer,
        preload: false,
      );
    correctAudioPlayer = AudioPlayer()
      ..setAsset(
        ModerniAliasSounds.correct,
        preload: false,
      );
    wrongAudioPlayer = AudioPlayer()
      ..setAsset(
        ModerniAliasSounds.wrong,
        preload: false,
      );
  }

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
    soundTimer?.cancel();
    gameTimer?.cancel();
    roundEndAudioPlayer.dispose();
    correctAudioPlayer.dispose();
    wrongAudioPlayer.dispose();
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

  /// Returns a `Timer` with the specified length and color
  Timer makeTimer({
    required double chosenSeconds,
    required int lengthOfRound,
    required String background,
  }) =>
      Timer(
        Duration(seconds: lengthOfRound - chosenSeconds.round()),
        () => useDynamicBackgrounds
            ? backgroundImage.changeBackground(
                background,
                isTemporary: true,
              )
            : null,
      );

  /// Starts the time countdown
  void startTimer(int lengthOfRound) {
    /// Initialize timer that runs when the round is about to end
    soundTimer = Timer(
      Duration(seconds: lengthOfRound - 5),
      () => playSound(
        audioPlayer: roundEndAudioPlayer,
      ),
    );

    /// Initialize timers that change colors
    greenTimer = makeTimer(
      chosenSeconds: greenSeconds,
      lengthOfRound: lengthOfRound,
      background: ModerniAliasImages.blurredGreen,
    );
    yellowTimer = makeTimer(
      chosenSeconds: yellowSeconds,
      lengthOfRound: lengthOfRound,
      background: ModerniAliasImages.blurredYellow,
    );
    redTimer = makeTimer(
      chosenSeconds: redSeconds,
      lengthOfRound: lengthOfRound,
      background: ModerniAliasImages.blurredRed,
    );

    /// Start game timer
    gameTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        /// Timer is done, stop round
        if (lengthOfRound - timer.tick == 0) {
          timer.cancel();
          stopGameCheckWinner();
        }
      },
    );
  }

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
          startRound(
            lengthOfRound: lengthOfRound,
          );
        }
      },
    );

    await startAudioRecording();
  }

  ///
  /// ROUNDS
  ///

  /// Triggered when the counter finishes and round starts
  void startRound({
    required int lengthOfRound,
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
    startTimer(lengthOfRound);
  }

  /// Gets called when the game is on hold (round ended, waiting for new round start)
  void gameStopped() {
    updateState(
      newGameState: GameState.idle,
    );

    backgroundImage.revertBackground();

    soundTimer?.cancel();
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
    gameTimer?.cancel();
  }

  /// Check if there's a winner
  /// If no winner, continue the game with the next team
  /// If winner, show the confetti screen
  void stopGameCheckWinner() {
    gameStopped();

    /// Check if there are teams which have enough points to win the game
    final teamsWithEnoughPoints = getTeamsWithEnoughPoints();

    /// There are no teams with enough points, continue playing the game
    if (teamsWithEnoughPoints.isEmpty) {
      continueGame(value.teams);
      return;
    }

    ///
    /// There are teams which have enough points to win the game
    ///

    /// Round is not finished, continue playing the game
    final activeTeams = value.tieBreakTeams ?? value.teams;
    if (roundNotDone(activeTeams)) {
      continueGame(activeTeams);
    }

    /// Round is finished, play tie break if there are tied teams or end game
    else {
      handleTieBreak(
        getTiedTeams(teamsWithEnoughPoints),
      );
    }
  }

  /// Returns a list of `Teams` who have enough points to win the game
  List<Team> getTeamsWithEnoughPoints() => value.teams.where((team) => team.points >= pointsToWin).toList();

  // Find all teams that are tied for first place
  List<Team> getTiedTeams(List<Team> teamsWithEnoughPoints) {
    final maxPoints = teamsWithEnoughPoints.map((team) => team.points).reduce(max);
    return teamsWithEnoughPoints.where((team) => team.points == maxPoints).toList();
  }

  /// Checks if current round is finished
  bool roundNotDone(List<Team> teamsToCheck) {
    final currentTeamIndex = teamsToCheck.indexOf(value.playingTeam);

    /// Find the maximum points among the teams with enough points
    final maxPoints = teamsToCheck.map((team) => team.points).reduce(max);

    /// Check if the current team has reached the maximum points but is not the last team to play
    return value.playingTeam.points <= maxPoints && currentTeamIndex < teamsToCheck.length - 1;
  }

  /// Game went into tie break, handle accordingly
  void handleTieBreak(List<Team> tiedTeams) {
    updateState(
      newTieBreakTeams: tiedTeams,
    );

    if (tiedTeams.length > 1) {
      continueGame(tiedTeams);
    } else {
      endGame();
    }
  }

  /// Continues tie break with proper teams
  Future<void> continueGame(List<Team> playingTeams) async {
    // TODO
    // await showScoresSheet();

    await updateHiveStats(
      gameType: GameState.idle,
    );

    final currentTeamIndex = playingTeams.indexOf(
      value.playingTeam,
    );

    updateState(
      newPlayingTeam: currentTeamIndex < playingTeams.length - 1 ? playingTeams[currentTeamIndex + 1] : playingTeams[0],
    );
  }

  /// Ends game and goes to [NormalGameFinishedScreen]
  Future<void> endGame() async {
    updateState(
      newGameState: GameState.finished,
    );

    await backgroundImage.revertBackground();
    await updateHiveStats(gameType: GameState.finished);

// TODO
    // openNormalGameFinished(
    //   context,
    //   teams: value.teams,
    //   playedWords: value.playedWords,
    // );
  }

  void answerChosen({required Answer chosenAnswer}) {
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
    /// 2. Add an answer to the proper team
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    playAnswerSound(chosenAnswer: chosenAnswer);

    /// Update relevant state
    /// Get another random word
    updateState(
      newPlayingTeam: value.playingTeam.copyWith(
        points: value.playingTeam.points + 1,
        correctPoints: chosenAnswer == Answer.correct ? value.playingTeam.correctPoints + 1 : null,
        wrongPoints: chosenAnswer == Answer.wrong ? value.playingTeam.wrongPoints + 1 : null,
      ),
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

  /// Plays proper sound while pressing on the answers
  void playAnswerSound({required Answer chosenAnswer}) => playSound(
        audioPlayer: chosenAnswer == Answer.correct ? correctAudioPlayer : wrongAudioPlayer,
      );

  /// Shows scores sheet and dismisses it after some time
  Future<void> showScoresSheet(BuildContext context) async {
    showScores(
      context,
      teams: value.teams,
      playedWords: value.playedWords,
      backgroundImage: backgroundImage.value,
      dismissible: false,
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pop();
  }

  /// Generates proper `path` and starts audio recording
  Future<void> startAudioRecording() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${pathProvider.appDocDirectory}/$timestamp';
    await audioRecord.startRecording(path);
  }

  /// Stores the audio file to application directory
  Future<String?> saveAudioFile() async {
    try {
      return await audioRecord.stopRecording();
    } catch (e) {
      logger.e('Error in saveAudioFile()\n$e');
    }
    return null;
  }

  /// Save audio file and update stats and store them in [Hive]
  Future<void> updateHiveStats({required GameState gameType}) async {
    normalGameStats = normalGameStats.copyWith(
      endTime: gameType == GameState.finished ? DateTime.now() : null,
      rounds: [
        ...normalGameStats.rounds,
        Round(
          playedWords: List.from(value.playedWords),
          playingTeam: value.playingTeam,
          audioRecording: await saveAudioFile(),
        ),
      ],
    );

    if (gameType == GameState.finished) {
      await hive.addNormalGameStatsToBox(
        normalGameStats: normalGameStats,
      );
    }
  }
}
