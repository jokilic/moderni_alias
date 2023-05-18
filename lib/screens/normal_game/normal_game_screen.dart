import 'package:flutter/material.dart';

import './widgets/show_scores.dart';
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
import 'widgets/normal_game_info_section.dart';

class NormalGameScreen extends StatelessWidget {
  static const routeName = '/normal-game-screen';

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
                    child: NormalGameInfoSection(
                      currentlyPlayingTeam: gameService.currentlyPlayingTeam,
                      exitGame: exitGameModal,
                      showScores: () => showScores(
                        teams: gameService.teams,
                        playedWords: gameService.playedWords,
                      ),
                    ),
                  ),
                  if (gameService.currentGame == Game.normal)
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
                            currentGame: Game.normal,
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
                            chosenGame: Game.normal,
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
