import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../models/played_word/played_word.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../models/round/round.dart';
import '../../services/audio_record_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/providers.dart';
import '../../util/routing.dart';
import '../../widgets/background_image.dart';

final quickGameProvider = Provider.autoDispose.family<QuickGameController, BuildContext>(
  (ref, context) {
    final quickGameController = QuickGameController(
      ref: ref,
      context: context,
    );
    ref.onDispose(quickGameController.dispose);
    return quickGameController;
  },
  name: 'QuickGameProvider',
);

class QuickGameController {
  final BuildContext context;
  final Ref ref;

  QuickGameController({
    required this.context,
    required this.ref,
  }) {
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

  Timer? gameTimer;

  late QuickGameStats quickGameStats;

  late bool useDynamicBackgrounds;

  ///
  /// INIT
  ///

  void init() {
    quickGameStats = QuickGameStats(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      round: Round(playedWords: []),
      language: ref.read(chosenDictionaryProvider),
    );

    useDynamicBackgrounds = ref.read(hiveProvider).getSettingsFromBox().useDynamicBackgrounds;
  }

  ///
  /// DISPOSE
  ///

  void dispose() {
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();
    soundTimer?.cancel();
    gameTimer?.cancel();
  }

  ///
  /// TIMERS & COUNTDOWN
  ///

  /// Returns a Timer with the specified length and color
  Timer makeTimer({
    required double chosenSeconds,
    required String background,
  }) =>
      Timer(
        Duration(seconds: 60 - chosenSeconds.round()),
        () => useDynamicBackgrounds ? ref.read(backgroundImageProvider.notifier).changeBackground(background, isTemporary: true) : null,
      );

  /// Sets the variables and starts the time countdown
  void startTimer(int lengthOfRound) {
    /// Set the time when the colors in the circular timer change
    greenSeconds = lengthOfRound * 0.6;
    yellowSeconds = lengthOfRound * 0.4;
    redSeconds = lengthOfRound * 0.15;

    /// Initialize timer that runs when the round is about to end
    soundTimer = Timer(
      Duration(seconds: lengthOfRound - 5),
      () {
        ref.read(countdownPlayerProvider).load();
        ref.read(countdownPlayerProvider).play();
      },
    );

    /// Initialize timers that change colors
    greenTimer = makeTimer(
      chosenSeconds: greenSeconds,
      background: ModerniAliasImages.blurredGreen,
    );
    yellowTimer = makeTimer(
      chosenSeconds: yellowSeconds,
      background: ModerniAliasImages.blurredYellow,
    );
    redTimer = makeTimer(
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
          endGame(context);
        }
      },
    );
  }

  /// Counts down the 3 seconds before starting new round
  Future<void> start3SecondCountdown() async {
    ref.read(currentGameProvider.notifier).state = Game.starting;
    ref.read(counter3SecondsProvider.notifier).state = 3;

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        ref.read(counter3SecondsProvider.notifier).state -= 1;

        /// Timer is done, start round
        if (ref.read(counter3SecondsProvider) == 0) {
          timer.cancel();
          startRound(lengthOfRound: 60);
        }
      },
    );

    await startAudioRecording();
  }

  ///
  /// ROUNDS
  ///

  /// Reset variables and start the round
  void startRound({required int lengthOfRound}) {
    ref.read(playedWordsProvider).clear();

    ref.read(dictionaryProvider.notifier).getRandomWord();

    ref.read(currentGameProvider.notifier).state = Game.quick;

    if (useDynamicBackgrounds) {
      ref.read(backgroundImageProvider.notifier).changeBackground(
            ModerniAliasImages.blurredBlue,
            isTemporary: true,
          );
    }

    startTimer(lengthOfRound);
  }

  /// Goes to the confetti screen and shows info about the round
  Future<void> endGame(BuildContext context) async {
    ref.read(currentGameProvider.notifier).state = Game.end;
    await ref.read(backgroundImageProvider.notifier).revertBackground();

    await updateHiveStats();
    openQuickGameFinished(context);
  }

  ///
  /// ANSWER
  ///

  void answerChosen({required Answer chosenAnswer}) {
    /// Game is not running, handle tapping answer
    if (ref.read(currentGameProvider) == Game.tapToStart) {
      start3SecondCountdown();
      return;
    }

    /// Game is starting, don't do anything
    if (ref.read(currentGameProvider) == Game.starting) {
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
    ref.read(playedWordsProvider).add(
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
  /// RECORD
  ///

  /// Generates proper `path` and starts audio recording
  Future<void> startAudioRecording() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${ref.read(pathProvider).appDocDirectory}/$timestamp';
    await ref.read(audioRecordProvider).startRecording(path);
  }

  /// Stores the audio file to application directory
  Future<String?> saveAudioFile() async {
    try {
      return await ref.read(audioRecordProvider).stopRecording();
    } catch (e) {
      ref.read(loggerProvider).e('Error in saveAudioFile()\n$e');
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
        playedWords: List.from(ref.read(playedWordsProvider)),
        audioRecording: await saveAudioFile(),
      ),
    );
    await ref.read(hiveProvider).addQuickGameStatsToBox(quickGameStats: quickGameStats);
  }
}
