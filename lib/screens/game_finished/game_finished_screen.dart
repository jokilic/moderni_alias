import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../models/team/team.dart';
import '../../services/game_service.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../normal_game/widgets/show_scores.dart';

class GameFinishedScreen extends StatelessWidget {
  static const routeName = '/game-finished';

  @override
  Widget build(BuildContext context) {
    final gameService = Get.find<GameService>();
    final winningTeam = Get.arguments as Team;

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
              Align(
                child: GestureDetector(
                  onTap: gameService.exitToMainMenu,
                  behavior: HitTestBehavior.translucent,
                  child: SizedBox(
                    width: Get.width * 0.8,
                    height: 500,
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
                            text: 'winnerFirstString'.tr,
                            style: ModerniAliasTextStyles.winnerFirst,
                            children: [
                              TextSpan(
                                text: winningTeam.name,
                                style: ModerniAliasTextStyles.winnerTeam,
                              ),
                              TextSpan(text: 'winnerSecondString'.tr),
                              TextSpan(
                                text: '${winningTeam.points}',
                                style: ModerniAliasTextStyles.winnerPoints,
                              ),
                              TextSpan(text: 'winnerThirdString'.tr),
                            ],
                          ),
                        ),
                      ],
                    ),
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
