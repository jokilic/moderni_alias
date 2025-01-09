import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../controllers/audio_record_controller.dart';
import '../../services/dictionary_service.dart';
import '../../services/hive_service.dart';
import '../../util/providers.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/game_starting.dart';
import '../../widgets/scores/normal_game_info_section.dart';
import '../../widgets/scores/show_scores.dart';
import '../../widgets/time_counter.dart';
import '../../widgets/wrong_correct_buttons.dart';
import 'normal_game_controller.dart';

class NormalGameScreen extends StatelessWidget {
  const NormalGameScreen({required super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final currentlyPlayingTeam = ref.watch(currentlyPlayingTeamProvider);
    final currentGame = ref.watch(currentGameProvider);
    final playedWords = ref.watch(playedWordsProvider);
    final counter3Seconds = ref.watch(counter3SecondsProvider);
    final lengthOfRound = ref.watch(lengthOfRoundProvider);
    final teams = ref.watch(teamsProvider);

    final currentWord = ref.watch(dictionaryProvider);

    final useCircularTimer = ref.watch(hiveProvider).getSettingsFromBox().useCircularTimer;

    ref.watch(audioRecordProvider);

    final normalGameController = ref.watch(normalGameProvider(context));

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => exitGameModal(
        context,
        ref,
        backgroundImage: ref.watch(backgroundImageProvider),
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
                    child: NormalGameInfoSection(
                      currentlyPlayingTeam: currentlyPlayingTeam,
                      exitGame: () => exitGameModal(
                        context,
                        ref,
                        backgroundImage: ref.watch(backgroundImageProvider),
                      ),
                      showScores: () => showScores(
                        context,
                        teams: teams,
                        playedWords: playedWords,
                        backgroundImage: ref.watch(backgroundImageProvider),
                      ),
                    ),
                  ),

                  ///
                  /// PLAYING GAME
                  ///
                  if (currentGame == Game.normal)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameOn(
                          currentWord: currentWord,
                          length: lengthOfRound,
                          showCircularTimer: useCircularTimer,
                        ),
                      ),
                    )

                  ///
                  /// COUNTDOWN
                  ///
                  else if (currentGame == Game.starting)
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
                  else if (currentGame == Game.tapToStart)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameOff(
                          onTap: normalGameController.start3SecondCountdown,
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
                      wrongChosen: () => normalGameController.answerChosen(
                        chosenAnswer: Answer.wrong,
                      ),
                      correctChosen: () => normalGameController.answerChosen(
                        chosenAnswer: Answer.correct,
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
                            roundLength: lengthOfRound,
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
