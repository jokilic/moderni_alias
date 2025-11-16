import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../controllers/audio_record_controller.dart';
import '../../controllers/base_game_controller.dart';
import '../../models/team/team.dart';
import '../../services/background_image_service.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../services/path_provider_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game/exit_game.dart';
import '../../widgets/game/game_off.dart';
import '../../widgets/game/game_starting.dart';
import '../../widgets/scores/show_time_scores.dart';
import '../../widgets/wrong_correct_buttons.dart';
import 'time_game_controller.dart';
import 'widgets/time_game_info_section.dart';
import 'widgets/time_game_on.dart';

class TimeGameScreen extends WatchingStatefulWidget {
  final List<Team> teams;
  final int numberOfWords;

  const TimeGameScreen({
    required this.teams,
    required this.numberOfWords,
  });

  @override
  State<TimeGameScreen> createState() => _TimeGameScreenState();
}

class _TimeGameScreenState extends State<TimeGameScreen> {
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

    registerIfNotInitialized<TimeGameController>(
      () => TimeGameController(
        logger: getIt.get<LoggerService>(),
        dictionary: getIt.get<DictionaryService>(),
        backgroundImage: getIt.get<BackgroundImageService>(),
        hive: getIt.get<HiveService>(),
        baseGame: baseGame,
        passedTeams: widget.teams,
        numberOfWords: widget.numberOfWords,
        useDynamicBackgrounds: useDynamicBackgrounds,
      ),
      afterRegister: (controller) => controller.init(),
    );
  }

  @override
  void dispose() {
    unregisterIfInitialized<AudioRecordController>();
    unregisterIfInitialized<BaseGameController>();
    unregisterIfInitialized<TimeGameController>();

    recorderController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    final state = watchIt<TimeGameController>().value;

    final currentlyPlayingTeam = state.playingTeam;
    final gameState = state.gameState;
    final playedWords = state.playedWords;
    final counter3Seconds = state.counter3Seconds;
    final currentWord = state.currentWord;
    final timeGameDuration = state.timeGameDuration;

    final duration = '${timeGameDuration.inMinutes.toString().padLeft(2, '0')}:${(timeGameDuration.inSeconds % 60).toString().padLeft(2, '0')}';
    final numberOfGuessedWords = '${currentlyPlayingTeam.points} / ${widget.numberOfWords}';

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
                    child: TimeGameInfoSection(
                      currentlyPlayingTeam: currentlyPlayingTeam,
                      recorderController: recorderController,
                      exitGame: () => exitGameModal(context),
                      showScores: () => showTimeScores(
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
                          GameState.playing => TimeGameOn(
                            currentWord: currentWord ?? '',
                            time: duration,
                            numberOfGuessedWords: numberOfGuessedWords,
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
                            onTap: getIt.get<TimeGameController>().start3SecondCountdown,
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
                      wrongChosen: () => getIt.get<TimeGameController>().answerChosen(
                        chosenAnswer: Answer.wrong,
                        context: context,
                      ),
                      correctChosen: () => getIt.get<TimeGameController>().answerChosen(
                        chosenAnswer: Answer.correct,
                        context: context,
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
