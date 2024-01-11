import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/durations.dart';
import '../constants/icons.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';
import 'animated_gesture_detector.dart';

class GameOff extends StatelessWidget {
  final Function() onTap;

  const GameOff({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.sizeOf(context).width - 40,
        child: AnimatedGestureDetector(
          onTap: onTap,
          child: AnimatedColumn(
            fastAnimations: true,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ModerniAliasIcons.clickImage,
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
      );
}
