import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../services/game_service.dart';

class GameOff extends StatelessWidget {
  final Function() onTap;

  const GameOff({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularCountDownTimer(
              duration: 0,
              width: 0.9.sw,
              height: 0.6.sh,
              ringColor: darkBlueColor,
              fillColor: Get.find<GameService>().countdownTimerFillColor,
              strokeWidth: 36.w,
              textStyle: const TextStyle(
                color: Colors.transparent,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  clickImage,
                  height: 136.h,
                ),
                Text(
                  startGameOnPressString,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      );
}
