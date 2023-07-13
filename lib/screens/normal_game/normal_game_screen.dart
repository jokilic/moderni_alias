import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/scores/show_scores.dart';
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
import '../../widgets/wrong_correct_buttons.dart';
import 'normal_game_controller.dart';
import '../../widgets/scores/normal_game_info_section.dart';

class NormalGameScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;

    final currentlyPlayingTeam = ref.watch(currentlyPlayingTeamProvider);
    final currentGame = ref.watch(currentGameProvider);
    final countdownTimerFillColor = ref.watch(countdownTimerFillColorProvider);
    final playedWords = ref.watch(playedWordsProvider);
    final counter3Seconds = ref.watch(counter3SecondsProvider);
    final lengthOfRound = ref.watch(lengthOfRoundProvider);
    final teams = ref.watch(teamsProvider);

    final currentWord = ref.watch(dictionaryProvider);

    ref.watch(audioRecordProvider);

    final normalGameController = ref.watch(normalGameProvider);

    return WillPopScope(
      onWillPop: () => exitGameModal(context),
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
                  child: NormalGameInfoSection(
                    currentlyPlayingTeam: currentlyPlayingTeam,
                    exitGame: () => exitGameModal(context),
                    showScores: () => showScores(
                      teams: teams,
                      playedWords: playedWords,
                      context: context,
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
                        fillColor: countdownTimerFillColor,
                        length: lengthOfRound,
                        onComplete: () => normalGameController.stopGameCheckWinner(context),
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
                        onComplete: () => normalGameController.startRound(
                          chosenGame: Game.normal,
                          lengthOfRound: ref.read(lengthOfRoundProvider),
                        ),
                      ),
                    ),
                  )

                ///
                /// TAP TO START GAME
                ///
                else
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
