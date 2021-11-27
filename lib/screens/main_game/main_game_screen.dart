import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './widgets/playing_team_info.dart';
import './widgets/show_scores.dart';
import '../../constants/enums.dart';
import '../../services/game_service.dart';
import '../../widgets/background_image.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/game_off.dart';
import '../../widgets/game_on.dart';
import '../../widgets/wrong_correct_buttons.dart';
import '../home/home_screen.dart';

class MainGameScreen extends StatelessWidget {
  static const routeName = '/main-game-screen';

  final gameService = Get.find<GameService>();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () => exitGameModal(
          context: context,
          exitGameCallback: () {},
        ),
        child: Scaffold(
          body: BackgroundImage(
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    width: 1.sw,
                    child: PlayingTeamInfo(
                      currentlyPlayingTeam: gameService.currentlyPlayingTeam,
                      exitGame: () => exitGameModal(
                        context: context,
                        exitGameCallback: () {
                          // TODO: Logic in some game controller

                          // gamePlaying = false;
                          // simpleGamePlaying = false;
                          // soundTimer?.cancel();
                          // greenTimer?.cancel();
                          // yellowTimer?.cancel();
                          // redTimer?.cancel();
                          // quickSoundTimer?.cancel();
                          // countdownAudioPlayer.stop();
                          // countdownQuickAudioPlayer.stop();
                          // countdownTimerFillColor = darkBlueColor;

                          Get.offNamedUntil(
                            HomeScreen.routeName,
                            (route) => false,
                          );
                        },
                      ),
                      showScores: () => showScores(
                        context: context,
                        teams: gameService.teams,
                      ),
                    ),
                  ),
                  if (gameService.currentGame == Game.normal)
                    Positioned(
                      top: -75.h,
                      bottom: 0,
                      child: GameOn(
                        currentWord: '',
                        fillColor: Colors.indigo,
                        length: gameService.lengthOfRound,
                        onComplete: () => gameService.endOfRound(
                          currentGame: Game.normal,
                        ),
                      ),
                    )
                  else
                    Positioned(
                      top: -75.h,
                      bottom: 0,
                      child: GameOff(
                        onTap: gameService.startRound,
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    width: 1.sw,
                    child: WrongCorrectButtons(
                      wrongChosen: () => gameService.answerChosen(
                        chosenButton: Answer.correct,
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
      );
}
