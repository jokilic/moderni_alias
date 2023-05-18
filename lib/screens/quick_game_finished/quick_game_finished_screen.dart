import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../services/game_service.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/play_button.dart';
import '../normal_game/widgets/show_scores.dart';

class QuickGameFinishedScreen extends StatelessWidget {
  static const routeName = '/quick-game-finished-screen';

  @override
  Widget build(BuildContext context) {
    final gameService = Get.find<GameService>();

    return WillPopScope(
      onWillPop: () async {
        gameService.exitToMainMenu();
        return true;
      },
      child: Scaffold(
        body: BackgroundImage(
          child: Stack(
            children: [
              const Confetti(),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(pi),
                child: const Confetti(
                  waitDuration: ModerniAliasDurations.slowAnimation,
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: const Confetti(
                  waitDuration: ModerniAliasDurations.verySlowAnimation,
                ),
              ),
              Center(
                child: SizedBox(
                  height: Get.height,
                  width: Get.width * 0.8,
                  child: AnimatedColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ModerniAliasImages.clapImage,
                        height: 220,
                      ),
                      const SizedBox(height: 30),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'quickGameFinishedFirstString'.tr,
                          style: ModerniAliasTextStyles.quickGameFinished,
                          children: [
                            TextSpan(
                              text: gameService.correctAnswers.toString(),
                              style: ModerniAliasTextStyles.quickGameFinishedBold,
                            ),
                            TextSpan(text: 'quickGameFinishedSecondString'.tr),
                            TextSpan(
                              text: gameService.wrongAnswers.toString(),
                              style: ModerniAliasTextStyles.quickGameFinishedBold,
                            ),
                            TextSpan(
                              text: 'quickGameFinishedThirdString'.tr,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 72),
                      AnimatedColumn(
                        children: [
                          PlayButton(
                            text: 'quickGameFinishedPlayAgainString'.tr.toUpperCase(),
                            onPressed: gameService.startQuickGame,
                          ),
                          const SizedBox(height: 20),
                          PlayButton(
                            text: 'quickGameFinishedExitString'.tr.toUpperCase(),
                            onPressed: gameService.exitToMainMenu,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 48,
                right: 12,
                child: AnimatedGestureDetector(
                  onTap: () => showScores(
                    playedWords: gameService.playedWords,
                  ),
                  end: 0.8,
                  child: const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.format_list_numbered_rounded,
                      color: ModerniAliasColors.whiteColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
