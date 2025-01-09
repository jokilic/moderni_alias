import 'package:flutter/material.dart';

import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../controllers/audio_record_controller.dart';
import '../../services/dictionary_service.dart';
import '../../util/providers.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_starting.dart';
import '../../widgets/scores/show_time_scores.dart';
import '../../widgets/wrong_correct_buttons.dart';
import 'time_game_controller.dart';
import 'widgets/time_game_info_section.dart';
import 'widgets/time_game_on.dart';

class TimeGameScreen extends StatelessWidget {
  const TimeGameScreen({required super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final currentlyPlayingTeam = ref.watch(currentlyPlayingTeamProvider);
    final currentGame = ref.watch(currentGameProvider);
    final playedWords = ref.watch(playedWordsProvider);
    final counter3Seconds = ref.watch(counter3SecondsProvider);

    final currentWord = ref.watch(dictionaryProvider);

    ref.watch(audioRecordProvider);

    final timeGameController = ref.watch(timeGameProvider);

    final timeGameTimer = ref.watch(timeGameTimerProvider);
    final duration = '${timeGameTimer.inMinutes.toString().padLeft(2, '0')}:${(timeGameTimer.inSeconds % 60).toString().padLeft(2, '0')}';
    final numberOfGuessedWords = '${ref.read(currentlyPlayingTeamProvider).points} / ${ref.watch(wordsToWinProvider)}';

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
                    child: TimeGameInfoSection(
                      currentlyPlayingTeam: currentlyPlayingTeam,
                      exitGame: () => exitGameModal(
                        context,
                        ref,
                        backgroundImage: ref.watch(backgroundImageProvider),
                      ),
                      showScores: () => showTimeScores(
                        context,
                        playedWords: playedWords,
                      ),
                    ),
                  ),

                  ///
                  /// PLAYING GAME
                  ///
                  if (currentGame == Game.time)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: TimeGameOn(
                          currentWord: currentWord,
                          time: duration,
                          numberOfGuessedWords: numberOfGuessedWords,
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
                          onTap: timeGameController.start3SecondCountdown,
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
                      wrongChosen: () => timeGameController.answerChosen(
                        chosenAnswer: Answer.wrong,
                        context: context,
                      ),
                      correctChosen: () => timeGameController.answerChosen(
                        chosenAnswer: Answer.correct,
                        context: context,
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
