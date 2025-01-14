import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../constants/sounds.dart';
import '../../controllers/audio_record_controller.dart';
import '../../models/played_word/played_word.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../models/round/round.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/sound.dart';
import '../../util/typedef.dart';

class QuickGameController extends ValueNotifier<QuickGameState> implements Disposable {
  final LoggerService logger;
  final DictionaryService dictionary;
  final BackgroundImageService backgroundImage;
  final PathProviderService pathProvider;
  final HiveService hive;
  final AudioRecordController audioRecord;

  final int lengthOfRound;
  final bool useDynamicBackgrounds;

  QuickGameController({
    required this.logger,
    required this.dictionary,
    required this.backgroundImage,
    required this.pathProvider,
    required this.hive,
    required this.audioRecord,
    required this.lengthOfRound,
    required this.useDynamicBackgrounds,
  }) : super(
          (
            gameState: GameState.idle,
            counter3Seconds: 0,
            playedWords: [],
            currentWord: null,
          ),
        );

  ///
  /// VARIABLES
  ///

  late final greenSeconds = lengthOfRound * 0.6;
  late final yellowSeconds = lengthOfRound * 0.4;
  late final redSeconds = lengthOfRound * 0.15;

  late QuickGameStats quickGameStats;

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
    quickGameStats = QuickGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      round: Round(playedWords: []),
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
  }) =>
      value = (
        gameState: newGameState ?? value.gameState,
        counter3Seconds: newCounter3Seconds ?? value.counter3Seconds,
        playedWords: newPlayedWords ?? value.playedWords,
        currentWord: newCurrentWord ?? value.currentWord,
      );

  /// Returns a `Timer` with the specified length and color
  Timer makeTimerForBackground({
    required double chosenSeconds,
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
    greenTimer = makeTimerForBackground(
      chosenSeconds: greenSeconds,
      background: ModerniAliasImages.blurredGreen,
    );
    yellowTimer = makeTimerForBackground(
      chosenSeconds: yellowSeconds,
      background: ModerniAliasImages.blurredYellow,
    );
    redTimer = makeTimerForBackground(
      chosenSeconds: redSeconds,
      background: ModerniAliasImages.blurredRed,
    );

    /// Start game timer
    gameTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        /// Timer is done, end game
        if (lengthOfRound - timer.tick == 0) {
          timer.cancel();
          endGame();
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

  /// Triggered when the counter finishes and round starts
  void startRound({required int lengthOfRound}) {
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

  /// Goes to the confetti screen and shows info about the round
  Future<void> endGame() async {
    updateState(newGameState: GameState.finished);

    await backgroundImage.revertBackground();
    await updateHiveStats();

    // TODO
    // openQuickGameFinished(
    //   context,
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
    /// 2. Add an answer to the variable
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    playAnswerSound(chosenAnswer: chosenAnswer);

    /// Add answer to list of `playedWords` (for showing in the end of the round)
    /// Get another random word
    updateState(
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

  ///
  /// HIVE
  ///

  /// Update stats and store them in [Hive]
  Future<void> updateHiveStats() async {
    quickGameStats = quickGameStats.copyWith(
      endTime: DateTime.now(),
      round: Round(
        playedWords: List.from(value.playedWords),
        audioRecording: await saveAudioFile(),
      ),
    );

    await hive.addQuickGameStatsToBox(
      quickGameStats: quickGameStats,
    );
  }
}
