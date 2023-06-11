import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../models/played_word/played_word.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../models/round/round.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../util/providers.dart';
import '../../util/routing.dart';

final quickGameProvider = Provider.autoDispose<QuickGameController>(
  (ref) {
    final quickGameController = QuickGameController(ref);
    ref.onDispose(quickGameController.dispose);
    return quickGameController;
  },
  name: 'QuickGameProvider',
);

class QuickGameController {
  final ProviderRef ref;

  QuickGameController(this.ref) {
    init();
  }

  ///
  /// VARIABLES
  ///

  var greenSeconds = 0.0;
  var yellowSeconds = 0.0;
  var redSeconds = 0.0;

  Timer? greenTimer;
  Timer? yellowTimer;
  Timer? redTimer;
  Timer? soundTimer;

  late QuickGameStats quickGameStats;

  ///
  /// INIT
  ///

  void init() {
    quickGameStats = QuickGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      round: Round(playedWords: []),
      language: ref.read(chosenDictionaryProvider.notifier).state,
    );
  }

  ///
  /// DISPOSE
  ///

  void dispose() {
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
    soundTimer?.cancel();
  }

  ///
  /// TIMERS & COUNTDOWN
  ///

  /// Returns a Timer with the specified length and color
  Timer makeTimer({required double chosenSeconds, required Color chosenColor}) => Timer(
        Duration(seconds: 60 - chosenSeconds.round()),
        () => ref.read(countdownTimerFillColorProvider.notifier).state = chosenColor,
      );

  /// Sets the variables and starts the time countdown
  void startTimer() {
    /// Set the time when the colors in the circular timer change
    greenSeconds = 60 * 0.6;
    yellowSeconds = 60 * 0.4;
    redSeconds = 60 * 0.15;

    /// Initialize timer that runs when the round is about to end
    soundTimer = Timer(
      const Duration(seconds: 60 - 5),
      () {
        ref.read(countdownPlayerProvider).load();
        ref.read(countdownPlayerProvider).play();
      },
    );

    /// Initialize timers that change colors
    greenTimer = makeTimer(
      chosenSeconds: greenSeconds,
      chosenColor: ModerniAliasColors.greenColor,
    );
    yellowTimer = makeTimer(
      chosenSeconds: yellowSeconds,
      chosenColor: ModerniAliasColors.yellowColor,
    );
    redTimer = makeTimer(
      chosenSeconds: redSeconds,
      chosenColor: ModerniAliasColors.redColor,
    );
  }

  /// Counts down the 3 seconds before starting new round
  void start3SecondCountdown() {
    ref.read(currentGameProvider.notifier).state = Game.starting;
    ref.read(counter3SecondsProvider.notifier).state = 3;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        ref.read(counter3SecondsProvider.notifier).state -= 1;

        if (ref.read(counter3SecondsProvider.notifier).state == 0) {
          timer.cancel();
        }
      },
    );
  }

  ///
  /// ROUNDS
  ///

  /// Reset variables and start the round
  void startRound() {
    ref.read(playedWordsProvider.notifier).state.clear();

    ref.read(currentGameProvider.notifier).state = Game.quick;
    ref.read(countdownTimerFillColorProvider.notifier).state = ModerniAliasColors.blueColor;

    ref.read(dictionaryProvider.notifier).getRandomWord();

    startTimer();
  }

  /// Goes to the confetti screen and shows info about the round
  void endGame(BuildContext context) {
    updateHiveStats();
    goToQuickGameFinishedScreen(
      context,
      playedWords: ref.read(playedWordsProvider.notifier).state,
    );
  }

  ///
  /// ANSWER
  ///

  void answerChosen({required Answer chosenAnswer}) {
    /// Game is not running, handle tapping answer
    if (ref.read(currentGameProvider.notifier).state == Game.none) {
      start3SecondCountdown();
      return;
    }

    /// Game is starting, don't do anything
    if (ref.read(currentGameProvider.notifier).state == Game.starting) {
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
    ref.read(playedWordsProvider.notifier).state.add(
          PlayedWord(
            word: ref.read(dictionaryProvider),
            chosenAnswer: chosenAnswer,
          ),
        );

    /// Get another random word
    ref.read(dictionaryProvider.notifier).getRandomWord();
  }

  /// Plays proper sound while pressing on the answers
  void playAnswerSound({required Answer chosenAnswer}) {
    if (chosenAnswer == Answer.correct) {
      ref.read(correctPlayerProvider).load();
      ref.read(correctPlayerProvider).play();
    } else {
      ref.read(wrongPlayerProvider).load();
      ref.read(wrongPlayerProvider).play();
    }
  }

  ///
  /// HIVE
  ///

  /// Update stats and store them in [Hive]
  void updateHiveStats() {
    quickGameStats = quickGameStats.copyWith(
      endTime: DateTime.now(),
      round: Round(
        playedWords: List.from(ref.read(playedWordsProvider.notifier).state),
      ),
    );
    ref.read(hiveProvider).addQuickGameStatsToBox(quickGameStats: quickGameStats);
  }
}
