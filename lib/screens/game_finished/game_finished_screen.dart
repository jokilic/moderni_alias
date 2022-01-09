import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../services/game_service.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';

class GameFinishedScreen extends StatelessWidget {
  static const routeName = '/game-finished';

  final gameService = Get.find<GameService>();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          gameService.exitToMainMenu();
          return true;
        },
        child: BackgroundImage(
          child: Stack(
            children: [
              Positioned(
                top: 200.h,
                left: 0.5.sw,
                child: Confetti(),
              ),
              Positioned(
                bottom: 200.h,
                left: 0.5.sw,
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
              Align(
                child: GestureDetector(
                  onTap: gameService.exitToMainMenu,
                  child: SizedBox(
                    width: 0.8.sw,
                    height: 500.h,
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
                            text: 'winnerFirstString'.tr,
                            style: ModerniAliasTextStyles.winnerFirst,
                            children: [
                              TextSpan(
                                text: gameService.currentlyPlayingTeam.name,
                                style: ModerniAliasTextStyles.winnerTeam,
                              ),
                              TextSpan(text: 'winnerSecondString'.tr),
                              TextSpan(
                                text: gameService.currentlyPlayingTeam.points.toString(),
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
            ],
          ),
        ),
      );
}
