import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../services/game_service.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/play_button.dart';
import '../quick_game/quick_game_screen.dart';

class QuickGameFinishedScreen extends StatelessWidget {
  static const routeName = '/quick-game-finished-screen';

  final gameService = Get.find<GameService>();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () => exitGameModal(
          context: context,
          exitGameCallback: gameService.exitToMainMenu,
        ),
        child: BackgroundImage(
          child: Stack(
            children: [
              Positioned(
                top: 200.h,
                left: 0.5.sh,
                child: Confetti(),
              ),
              Positioned(
                bottom: 200.h,
                left: 0.5.sh,
                child: Confetti(),
              ),
              Positioned(
                top: 0.5.sh,
                left: 50.w,
                child: Confetti(),
              ),
              Positioned(
                top: 0.5.sh,
                right: 50.w,
                child: Confetti(),
              ),
              Center(
                child: SizedBox(
                  height: 1.sh,
                  width: 0.8.sw,
                  child: Column(
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
                          style: Theme.of(context).textTheme.bodyText1,
                          children: [
                            TextSpan(
                              text: gameService.correctAnswers.toString(),
                              style: Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            TextSpan(text: 'quickGameFinishedSecondString'.tr),
                            TextSpan(
                              text: gameService.wrongAnswers.toString(),
                              style: Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            TextSpan(
                              text: 'quickGameFinishedThirdString'.tr,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.h),
                      Column(
                        children: [
                          PlayButton(
                            text: 'quickGameFinishedPlayAgainString'.tr.toUpperCase(),
                            onPressed: () => Get.offNamed(
                              QuickGameScreen.routeName,
                            ),
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
            ],
          ),
        ),
      );
}
