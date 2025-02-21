import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../controllers/base_game_controller.dart';
import '../../models/played_word/played_word.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../models/round/round.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/routing.dart';
import '../../util/typedef.dart';

class QuickGameController extends ValueNotifier<QuickGameState> {
  final LoggerService logger;
  final DictionaryService dictionary;
  final BackgroundImageService backgroundImage;
  final HiveService hive;
  final BaseGameController baseGame;

  final int lengthOfRound;
  final bool useDynamicBackgrounds;

  QuickGameController({
    required this.logger,
    required this.dictionary,
    required this.backgroundImage,
    required this.hive,
    required this.baseGame,
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

  late QuickGameStats quickGameStats;

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
      path: 'moderni_alias_quick_game_${quickGameStats.startTime.millisecondsSinceEpoch}_audio',
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
      onGameTimerFinished: () => endGame(
        context: context,
      ),
    );
  }

  /// Goes to the confetti screen and shows info about the round
  Future<void> endGame({required BuildContext context}) async {
    updateState(
      newGameState: GameState.finished,
    );

    await backgroundImage.revertBackground();
    await updateStatsAndUsedWords();
    await WakelockPlus.disable();

    openQuickGameFinished(
      context,
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
    /// 2. Add an answer to the variable
    /// 3. Add answer to list of `playedWords` (for showing in the end of the round)
    /// 4. Get another random word

    /// Play proper sound
    baseGame.playAnswerSound(
      chosenAnswer: chosenAnswer,
    );

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

  /// Save audio file and update stats and store them in [Hive]
  /// Update `usedWords` in [Dictionary] and [Hive]
  Future<void> updateStatsAndUsedWords() async {
    final newPlayedWords = List<PlayedWord>.from(value.playedWords);

    quickGameStats = quickGameStats.copyWith(
      endTime: DateTime.now(),
      round: Round(
        playedWords: newPlayedWords,
        audioRecording: await baseGame.saveAudioFile(),
      ),
    );

    /// Update used words in [Dictionary] and [Hive]
    await baseGame.updateUsedWords(newPlayedWords);

    /// Game finished, add new stats to [Hive]
    await hive.addQuickGameStatsToBox(
      quickGameStats: quickGameStats,
    );
  }
}
