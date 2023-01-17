import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './widgets/show_scores.dart';
import '../../constants/enums.dart';
import '../../services/dictionary_service.dart';
import '../../services/game_service.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/game_starting.dart';
import '../../widgets/wrong_correct_buttons.dart';
import 'widgets/main_game_info_section.dart';

class MainGameScreen extends StatelessWidget {
  static const routeName = '/main-game-screen';

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
                    child: MainGameInfoSection(
                      currentlyPlayingTeam: gameService.currentlyPlayingTeam,
                      exitGame: () => exitGameModal(
                        exitGameCallback: gameService.exitToMainMenu,
                      ),
                      showScores: () => showScores(
                        context: context,
                        teams: gameService.teams,
                        playedWords: gameService.playedWords,
                      ),
                    ),
                  ),
                  if (gameService.currentGame == Game.normal)
                    Positioned(
                      top: -75.h,
                      bottom: 0,
                      child: GameOn(
                        currentWord: dictionaryService.currentWord,
                        fillColor: gameService.countdownTimerFillColor,
                        length: gameService.lengthOfRound,
                        onComplete: () => gameService.endOfRound(
                          currentGame: Game.normal,
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
                          chosenGame: Game.normal,
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
                      wrongChosen: () => gameService.answerChosen(
                        chosenButton: Answer.wrong,
                      ),
                      correctChosen: () => gameService.answerChosen(
                        chosenButton: Answer.correct,
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
