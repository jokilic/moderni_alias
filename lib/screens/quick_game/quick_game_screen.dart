import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../controllers/audio_record_controller.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/game_starting.dart';
import '../../widgets/scores/show_scores.dart';
import '../../widgets/time_counter.dart';
import '../../widgets/wrong_correct_buttons.dart';
import 'quick_game_controller.dart';
import 'widgets/quick_game_info_section.dart';

class QuickGameScreen extends WatchingStatefulWidget {
  const QuickGameScreen({required super.key});

  @override
  State<QuickGameScreen> createState() => _QuickGameScreenState();
}

class _QuickGameScreenState extends State<QuickGameScreen> {
  final roundLength = 60;

  late bool useCircularTimer;

  @override
  void initState() {
    super.initState();

    final audioRecord = getIt.registerSingleton(
      AudioRecordController(
        recorderController: RecorderController(),
        logger: getIt.get<LoggerService>(),
      ),
    );

    final settings = getIt.get<HiveService>().getSettingsFromBox();

    final useDynamicBackgrounds = settings.useDynamicBackgrounds;
    useCircularTimer = settings.useCircularTimer;

    registerIfNotInitialized<QuickGameController>(
      () => QuickGameController(
        logger: getIt.get<LoggerService>(),
        dictionary: getIt.get<DictionaryService>(),
        backgroundImage: getIt.get<BackgroundImageService>(),
        pathProvider: getIt.get<PathProviderService>(),
        hive: getIt.get<HiveService>(),
        audioRecord: audioRecord,
        lengthOfRound: roundLength,
        useDynamicBackgrounds: useDynamicBackgrounds,
      ),
    );
  }

  @override
  void dispose() {
    getIt
      ..unregister<AudioRecordController>()
      ..unregister<QuickGameController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final backgroundImage = watchIt<BackgroundImageService>().value;

    final state = watchIt<QuickGameController>().value;
    final currentGame = state.gameState;
    final playedWords = state.playedWords;
    final counter3Seconds = state.counter3Seconds;
    final currentWord = state.currentWord;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => exitGameModal(
        context,
        backgroundImage: backgroundImage,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
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
                      recorderController: getIt.get<AudioRecordController>().recorderController,
                      correctAnswers: playedWords.where((word) => word.chosenAnswer == Answer.correct).length,
                      wrongAnswers: playedWords.where((word) => word.chosenAnswer == Answer.wrong).length,
                      exitGame: () => exitGameModal(
                        context,
                        backgroundImage: backgroundImage,
                      ),
                      showScores: () => showScores(
                        context,
                        playedWords: playedWords,
                        backgroundImage: backgroundImage,
                      ),
                    ),
                  ),

                  ///
                  /// PLAYING GAME
                  ///
                  if (currentGame == GameState.playing && currentWord != null)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameOn(
                          currentWord: currentWord,
                          length: roundLength,
                          showCircularTimer: useCircularTimer,
                        ),
                      ),
                    )

                  ///
                  /// COUNTDOWN
                  ///
                  else if (currentGame == GameState.starting)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameStarting(
                          currentSecond: counter3Seconds != 0 ? '$counter3Seconds' : '',
                        ),
                      ),
                    )

                  ///
                  /// TAP TO START GAME
                  ///
                  else if (currentGame == GameState.idle)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameOff(
                          onTap: getIt.get<QuickGameController>().start3SecondCountdown,
                        ),
                      ),
                    ),

                  ///
                  /// BOTTOM - ANSWERS BUTTONS
                  ///
                  Positioned(
                    bottom: 0,
                    width: width,
                    child: WrongCorrectButtons(
                      correctChosen: () => getIt.get<QuickGameController>().answerChosen(
                            chosenAnswer: Answer.correct,
                          ),
                      wrongChosen: () => getIt.get<QuickGameController>().answerChosen(
                            chosenAnswer: Answer.wrong,
                          ),
                    ),
                  ),

                  ///
                  /// BOTTOM - TIME COUNTER
                  ///
                  if (!useCircularTimer)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: IgnorePointer(
                        child: SizedBox(
                          height: 8,
                          width: width,
                          child: TimeCounter(
                            roundLength: roundLength,
                          ),
                        ),
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
