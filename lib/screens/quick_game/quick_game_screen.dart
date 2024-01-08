import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../services/audio_record_service.dart';
import '../../services/dictionary_service.dart';
import '../../util/providers.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/game_starting.dart';
import '../../widgets/scores/show_scores.dart';
import '../../widgets/wrong_correct_buttons.dart';
import 'quick_game_controller.dart';
import 'widgets/quick_game_info_section.dart';

class QuickGameScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;

    final currentGame = ref.watch(currentGameProvider);
    final countdownTimerFillColor = ref.watch(countdownTimerFillColorProvider);
    final playedWords = ref.watch(playedWordsProvider);
    final counter3Seconds = ref.watch(counter3SecondsProvider);

    final currentWord = ref.watch(dictionaryProvider);

    ref.watch(audioRecordProvider);

    final quickGameController = ref.watch(quickGameProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (_) => exitGameModal(context),
      child: Scaffold(
        body: BackgroundImage(
          child: SafeArea(
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
                    correctAnswers: playedWords.where((word) => word.chosenAnswer == Answer.correct).length,
                    wrongAnswers: playedWords.where((word) => word.chosenAnswer == Answer.wrong).length,
                    exitGame: () => exitGameModal(context),
                    showScores: () => showScores(
                      context,
                      playedWords: ref.read(playedWordsProvider),
                    ),
                  ),
                ),

                ///
                /// PLAYING GAME
                ///
                if (currentGame == Game.quick)
                  Positioned(
                    top: -75,
                    bottom: 0,
                    child: AnimatedSwitcher(
                      duration: ModerniAliasDurations.fastAnimation,
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeIn,
                      child: GameOn(
                        currentWord: currentWord,
                        fillColor: countdownTimerFillColor,
                        length: 60,
                        onComplete: () => quickGameController.endGame(context),
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
                        onComplete: () => quickGameController.startRound(lengthOfRound: 60),
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
                        onTap: quickGameController.start3SecondCountdown,
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
                    correctChosen: () => quickGameController.answerChosen(
                      chosenAnswer: Answer.correct,
                    ),
                    wrongChosen: () => quickGameController.answerChosen(
                      chosenAnswer: Answer.wrong,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
