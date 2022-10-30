import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../services/game_service.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/play_button.dart';
import '../main_game/widgets/show_scores.dart';

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
              const Align(
                alignment: Alignment.topCenter,
                child: Confetti(
                  waitDuration: ModerniAliasDurations.verySlowAnimation,
                ),
              ),
              const Align(
                child: Confetti(),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Confetti(
                  waitDuration: ModerniAliasDurations.slowAnimation,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 1.sh,
                  width: 0.8.sw,
                  child: AnimatedColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ModerniAliasImages.clapImage,
                        height: 220.h,
                      ),
                      SizedBox(height: 30.h),
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
                      SizedBox(height: 72.h),
                      AnimatedColumn(
                        children: [
                          PlayButton(
                            text: 'quickGameFinishedPlayAgainString'.tr.toUpperCase(),
                            onPressed: gameService.startQuickGame,
                          ),
                          SizedBox(height: 20.h),
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
                top: 48.h,
                right: 12.w,
                child: IconButton(
                  onPressed: () => showScores(
                    context: context,
                    playedWords: gameService.playedWords,
                  ),
                  icon: Icon(
                    Icons.format_list_numbered,
                    color: ModerniAliasColors.whiteColor,
                    size: 30.r,
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
