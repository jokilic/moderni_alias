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
import '../../widgets/wrong_correct_buttons.dart';
import 'widgets/quick_game_info_section.dart';

class QuickGameScreen extends StatelessWidget {
  static const routeName = '/quick-game-screen';

  final dictionaryService = Get.find<DictionaryService>();
  final gameService = Get.find<GameService>();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () => exitGameModal(
          context: context,
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
                        exitGame: () => exitGameModal(
                          context: context,
                          exitGameCallback: gameService.exitToMainMenu,
                        ),
                        correctAnswers: gameService.correctAnswers,
                        wrongAnswers: gameService.wrongAnswers,
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
                    else
                      Positioned(
                        top: -75.h,
                        bottom: 0,
                        child: GameOff(
                          onTap: () => gameService.startRound(
                            chosenGame: Game.quick,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      width: 1.sw,
                      child: WrongCorrectButtons(
                        correctChosen: () => gameService.answerChosen(
                          chosenButton: Answer.correct,
                          context: context,
                        ),
                        wrongChosen: () => gameService.answerChosen(
                          chosenButton: Answer.wrong,
                          context: context,
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
