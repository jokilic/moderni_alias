import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/enums.dart';
import '../../services/dictionary_service.dart';
import '../../services/game_service.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/game_starting.dart';
import '../../widgets/wrong_correct_buttons.dart';
import '../main_game/widgets/show_scores.dart';
import 'widgets/quick_game_info_section.dart';

class QuickGameScreen extends StatelessWidget {
  static const routeName = '/quick-game-screen';

  @override
  Widget build(BuildContext context) {
    final dictionaryService = Get.find<DictionaryService>();
    final gameService = Get.find<GameService>();

    return WillPopScope(
      onWillPop: () => exitGameModal(
        exitGameCallback: gameService.exitToMainMenu,
      ),
      child: Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: Obx(
              () => Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    width: 1.sw,
                    child: QuickGameInfoSection(
                      correctAnswers: gameService.correctAnswers,
                      wrongAnswers: gameService.wrongAnswers,
                      exitGame: () => exitGameModal(
                        exitGameCallback: gameService.exitToMainMenu,
                      ),
                      showScores: () => showScores(
                        context: context,
                        playedWords: gameService.playedWords,
                      ),
                    ),
                  ),
                  if (gameService.currentGame == Game.quick)
                    Positioned(
                      top: -75.h,
                      bottom: 0,
                      child: GameOn(
                        currentWord: dictionaryService.currentWord,
                        fillColor: gameService.countdownTimerFillColor,
                        length: gameService.lengthOfRound,
                        onComplete: () => gameService.endOfRound(
                          currentGame: Game.quick,
                        ),
                      ),
                    )
                  else if (gameService.currentGame == Game.starting)
                    Positioned(
                      top: -75.h,
                      bottom: 0,
                      child: GameStarting(
                        currentSecond: gameService.counter3Seconds != 0 ? '${gameService.counter3Seconds}' : '',
                        onComplete: () => gameService.startRound(
                          chosenGame: Game.quick,
                        ),
                      ),
                    )
                  else
                    Positioned(
                      top: -75.h,
                      bottom: 0,
                      child: GameOff(
                        onTap: gameService.start3SecondCountdown,
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    width: 1.sw,
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
