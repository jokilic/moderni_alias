import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/enums.dart';
import '../constants/images.dart';
import '../constants/sounds.dart';
import '../models/played_word/played_word.dart';
import '../models/team/team.dart';
import '../services/background_image_service.dart';
import '../services/dictionary_service.dart';
import '../services/logger_service.dart';
import '../services/path_provider_service.dart';
import '../util/sound.dart';
import '../widgets/scores/show_scores.dart';
import '../widgets/scores/show_time_scores.dart';
import 'audio_record_controller.dart';

class BaseGameController implements Disposable {
  final LoggerService logger;
  final DictionaryService dictionary;
  final PathProviderService pathProvider;
  final BackgroundImageService backgroundImage;
  final AudioRecordController? audioRecord;

  BaseGameController({
    required this.logger,
    required this.dictionary,
    required this.pathProvider,
    required this.backgroundImage,
    required this.audioRecord,
  });

  ///
  /// VARIABLES
  ///

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

  /// Returns a `Timer` with the specified length and color
  Timer makeTimer({
    required double chosenSeconds,
    required int lengthOfRound,
    required String background,
    required bool useDynamicBackgrounds,
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
  void startTimers(
    int lengthOfRound, {
    required bool useDynamicBackgrounds,
    required Function() onGameTimerFinished,
  }) {
    /// Calculate seconds for each timer
    final greenSeconds = lengthOfRound * 0.6;
    final yellowSeconds = lengthOfRound * 0.4;
    final redSeconds = lengthOfRound * 0.15;

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
      useDynamicBackgrounds: useDynamicBackgrounds,
    );
    yellowTimer = makeTimer(
      chosenSeconds: yellowSeconds,
      lengthOfRound: lengthOfRound,
      background: ModerniAliasImages.blurredYellow,
      useDynamicBackgrounds: useDynamicBackgrounds,
    );
    redTimer = makeTimer(
      chosenSeconds: redSeconds,
      lengthOfRound: lengthOfRound,
      background: ModerniAliasImages.blurredRed,
      useDynamicBackgrounds: useDynamicBackgrounds,
    );

    /// Start game timer
    gameTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        /// Timer is done, stop round
        if (lengthOfRound - timer.tick == 0) {
          timer.cancel();
          onGameTimerFinished();
        }
      },
    );
  }

  /// Stops and cancels all timers
  void cancelTimers() {
    greenTimer?.cancel();
    yellowTimer?.cancel();
    redTimer?.cancel();

    soundTimer?.cancel();
    gameTimer?.cancel();
  }

  /// Plays proper sound while pressing on the answers
  void playAnswerSound({required Answer chosenAnswer}) => playSound(
        audioPlayer: chosenAnswer == Answer.correct ? correctAudioPlayer : wrongAudioPlayer,
      );

  /// Shows scores sheet and dismisses it after some time
  Future<void> showScoresSheet({
    required List<Team> teams,
    required List<PlayedWord> playedWords,
    required String backgroundImage,
    required BuildContext context,
  }) async {
    showScores(
      context,
      teams: teams,
      playedWords: playedWords,
      dismissible: false,
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pop();
  }

  /// Shows time scores sheet and dismisses it after some time
  Future<void> showTimeScoresSheet({
    required List<PlayedWord> playedWords,
    required BuildContext context,
  }) async {
    showTimeScores(
      context,
      playedWords: playedWords,
      dismissible: false,
      roundEnd: true,
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pop();
  }

  /// Changes background depending on the percentage of solved words
  void updateTimeBackground({
    required List<PlayedWord> playedWords,
    required int numberOfWords,
  }) {
    final correctAnswers = playedWords.where((word) => word.chosenAnswer == Answer.correct).toList().length;

    final percentageOfSolvedWords = 1 - (correctAnswers / numberOfWords);

    /// Show green background
    if (percentageOfSolvedWords <= 0.6 && percentageOfSolvedWords > 0.4) {
      backgroundImage.changeBackground(
        ModerniAliasImages.blurredGreen,
        isTemporary: true,
      );
    }

    /// Show yellow background
    else if (percentageOfSolvedWords <= 0.4 && percentageOfSolvedWords > 0.15) {
      backgroundImage.changeBackground(
        ModerniAliasImages.blurredYellow,
        isTemporary: true,
      );
    }

    /// Show red background
    else if (percentageOfSolvedWords <= 0.15) {
      backgroundImage.changeBackground(
        ModerniAliasImages.blurredRed,
        isTemporary: true,
      );
    }
  }

  /// Generates proper `path` and starts audio recording
  Future<void> startAudioRecording({required String path}) async {
    if (audioRecord != null) {
      final absolutePath = '${pathProvider.persistenceDirectory}/$path.m4a';
      await audioRecord!.startRecording(absolutePath);
    }
  }

  /// Stores the audio file to application directory
  Future<String?> saveAudioFile() async {
    if (audioRecord != null) {
      try {
        return await audioRecord!.stopRecording();
      } catch (e) {
        logger.e('Error in saveAudioFile()\n$e');
      }
    }
    return null;
  }

  /// Updates [Set] and [Hive] with played words from last round
  Future<void> updateUsedWords(List<PlayedWord> playedWords) async {
    final words = playedWords.map((playedWord) => playedWord.word).toList();
    await dictionary.updateUsedWords(words);
  }
}
