import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../controllers/audio_record_controller.dart';
import '../../controllers/base_game_controller.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game/exit_game.dart';
import '../../widgets/game/game_off.dart';
import '../../widgets/game/game_on.dart';
import '../../widgets/game/game_starting.dart';
import '../../widgets/scores/show_scores.dart';
import '../../widgets/time_counter.dart';
import '../../widgets/wrong_correct_buttons.dart';
import 'quick_game_controller.dart';
import 'widgets/quick_game_info_section.dart';

class QuickGameScreen extends WatchingStatefulWidget {
  final int lengthOfRound;

  const QuickGameScreen({
    required this.lengthOfRound,
  });

  @override
  State<QuickGameScreen> createState() => _QuickGameScreenState();
}

class _QuickGameScreenState extends State<QuickGameScreen> {
  late bool useCircularTimer;
  RecorderController? recorderController;
  AudioRecordController? audioRecord;

  @override
  void initState() {
    super.initState();

    final settings = getIt.get<HiveService>().getSettingsFromBox();

    final useDynamicBackgrounds = settings.useDynamicBackgrounds;
    useCircularTimer = settings.useCircularTimer;

    /// Initialize audio recording on mobile platforms
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      recorderController = RecorderController();

      audioRecord = registerIfNotInitialized<AudioRecordController>(
        () => AudioRecordController(
          recorderController: recorderController!,
          logger: getIt.get<LoggerService>(),
        ),
        afterRegister: (controller) => controller.init(),
      );
    }

    final baseGame = registerIfNotInitialized<BaseGameController>(
      () => BaseGameController(
        logger: getIt.get<LoggerService>(),
        dictionary: getIt.get<DictionaryService>(),
        pathProvider: getIt.get<PathProviderService>(),
        backgroundImage: getIt.get<BackgroundImageService>(),
        audioRecord: audioRecord,
      ),
      afterRegister: (controller) => controller.init(),
    );

    registerIfNotInitialized<QuickGameController>(
      () => QuickGameController(
        logger: getIt.get<LoggerService>(),
        dictionary: getIt.get<DictionaryService>(),
        backgroundImage: getIt.get<BackgroundImageService>(),
        hive: getIt.get<HiveService>(),
        baseGame: baseGame,
        lengthOfRound: widget.lengthOfRound,
        useDynamicBackgrounds: useDynamicBackgrounds,
      ),
      afterRegister: (controller) => controller.init(),
    );
  }

  @override
  void dispose() {
    unregisterIfInitialized<AudioRecordController>();
    unregisterIfInitialized<BaseGameController>();
    unregisterIfInitialized<QuickGameController>();

    recorderController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    final controller = watchIt<QuickGameController>();
    final state = controller.value;

    final gameState = state.gameState;
    final playedWords = state.playedWords;
    final counter3Seconds = state.counter3Seconds;
    final currentWord = state.currentWord;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => exitGameModal(context),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              bottom: false,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ///
                  /// TOP - EXIT & SCORES BUTTONS
                  ///
                  Positioned(
                    top: 0,
                    width: width,
                    child: QuickGameInfoSection(
                      recorderController: recorderController,
                      correctAnswers: playedWords.where((word) => word.chosenAnswer == Answer.correct).length,
                      wrongAnswers: playedWords.where((word) => word.chosenAnswer == Answer.wrong).length,
                      exitGame: () => exitGameModal(context),
                      showScores: () => showScores(
                        context,
                        playedWords: playedWords,
                      ),
                    ),
                  ),

                  ///
                  /// GAME CONTENT
                  ///
                  Positioned(
                    top: -75,
                    bottom: 0,
                    child: AnimatedSwitcher(
                      duration: ModerniAliasDurations.fastAnimation,
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeIn,
                      child: SizedBox(
                        key: ValueKey(gameState),
                        child: switch (gameState) {
                          ///
                          /// PLAYING GAME
                          ///
                          GameState.playing => GameOn(
                            currentWord: currentWord ?? '',
                            length: widget.lengthOfRound,
                            showCircularTimer: useCircularTimer,
                          ),

                          ///
                          /// COUNTDOWN
                          ///
                          GameState.starting => GameStarting(
                            currentSecond: counter3Seconds != 0 ? '$counter3Seconds' : '',
                          ),

                          ///
                          /// TAP TO START GAME
                          ///
                          GameState.idle => GameOff(
                            onTap: () => getIt.get<QuickGameController>().start3SecondCountdown(
                              context: context,
                            ),
                          ),

                          ///
                          /// FINISHED (shouldn't happen)
                          ///
                          _ => const SizedBox.shrink(),
                        },
                      ),
                    ),
                  ),

                  ///
                  /// BOTTOM - ANSWERS BUTTONS
                  ///
                  Positioned(
                    bottom: bottomPadding,
                    width: width,
                    child: WrongCorrectButtons(
                      correctChosen: () => getIt.get<QuickGameController>().answerChosen(
                        chosenAnswer: Answer.correct,
                        context: context,
                      ),
                      wrongChosen: () => getIt.get<QuickGameController>().answerChosen(
                        chosenAnswer: Answer.wrong,
                        context: context,
                      ),
                    ),
                  ),

                  ///
                  /// BOTTOM - TIME COUNTER
                  ///
                  if (!useCircularTimer)
                    Positioned(
                      bottom: bottomPadding,
                      left: 0,
                      child: IgnorePointer(
                        child: SizedBox(
                          height: 8,
                          width: width,
                          child: TimeCounter(
                            lengthOfRound: widget.lengthOfRound,
                            quickGameController: controller,
                          ),
                        ),
                      ),
                    ),

                  ///
                  /// BOTTOM - PADDING COLOR
                  ///
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: bottomPadding,
                      width: width,
                      color: ModerniAliasColors.white.withValues(alpha: 0.05),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
