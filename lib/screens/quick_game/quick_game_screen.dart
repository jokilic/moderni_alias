import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../services/dictionary_service.dart';
import '../../services/game_service.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/game_starting.dart';
import '../../widgets/wrong_correct_buttons.dart';
import '../normal_game/widgets/show_scores.dart';
import 'widgets/quick_game_info_section.dart';

class QuickGameScreen extends StatelessWidget {
  static const routeName = '/quick-game-screen';

  @override
  Widget build(BuildContext context) {
    final dictionaryService = Get.find<DictionaryService>();
    final gameService = Get.find<GameService>();

    return WillPopScope(
      onWillPop: exitGameModal,
      child: Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: Obx(
              () => Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    width: Get.width,
                    child: QuickGameInfoSection(
                      correctAnswers: gameService.correctAnswers,
                      wrongAnswers: gameService.wrongAnswers,
                      exitGame: exitGameModal,
                      showScores: () => showScores(
                        playedWords: gameService.playedWords,
                      ),
                    ),
                  ),
                  if (gameService.currentGame == Game.quick)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameOn(
                          currentWord: dictionaryService.currentWord,
                          fillColor: gameService.countdownTimerFillColor,
                          length: gameService.lengthOfRound,
                          onComplete: () => gameService.endOfRound(
                            currentGame: Game.quick,
                          ),
                        ),
                      ),
                    )
                  else if (gameService.currentGame == Game.starting)
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameStarting(
                          currentSecond: gameService.counter3Seconds != 0 ? '${gameService.counter3Seconds}' : '',
                          onComplete: () => gameService.startRound(
                            chosenGame: Game.quick,
                          ),
                        ),
                      ),
                    )
                  else
                    Positioned(
                      top: -75,
                      bottom: 0,
                      child: AnimatedSwitcher(
                        duration: ModerniAliasDurations.fastAnimation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: GameOff(
                          onTap: gameService.start3SecondCountdown,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    width: Get.width,
                    child: WrongCorrectButtons(
                      correctChosen: () => gameService.answerChosen(
                        chosenButton: Answer.correct,
                      ),
                      wrongChosen: () => gameService.answerChosen(
                        chosenButton: Answer.wrong,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
