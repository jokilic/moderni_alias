import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../services/game_service.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/exit_game.dart';

class GameFinishedScreen extends StatelessWidget {
  static const routeName = '/game-finished';

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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          clapImage,
                          height: 220.h,
                        ),
                        SizedBox(height: 30.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'winnerFirstString'.tr,
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              TextSpan(
                                text: gameService.currentlyPlayingTeam.name,
                                style: Theme.of(context).textTheme.headline2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(text: 'winnerSecondString'.tr),
                              TextSpan(
                                text: gameService.currentlyPlayingTeam.points.toString(),
                                style: Theme.of(context).textTheme.headline2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
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
