import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/strings.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';
import 'animated_gesture_detector.dart';

class GameOff extends StatelessWidget {
  final Function() onTap;

  const GameOff({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircularCountDownTimer(
          duration: 0,
          width: size.width * 0.9,
          height: size.height * 0.6,
          ringColor: Colors.transparent,
          fillColor: Colors.transparent,
          strokeWidth: 36,
          textStyle: ModerniAliasTextStyles.gameCircularCountdown,
        ),
        AnimatedGestureDetector(
          onTap: onTap,
          child: AnimatedColumn(
            fastAnimations: true,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ModerniAliasImages.clickImage,
                height: 136,
              ),
              const SizedBox(height: 16),
              FadeInAnimation(
                curve: Curves.easeIn,
                duration: ModerniAliasDurations.slowAnimation,
                delay: ModerniAliasDurations.animation,
                child: Text(
                  'startGameOnPressString'.tr(),
                  style: ModerniAliasTextStyles.gameOffStart,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
