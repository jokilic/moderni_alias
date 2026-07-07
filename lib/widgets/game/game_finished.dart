import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../constants/durations.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../animated_column.dart';
import '../animated_gesture_detector.dart';

class GameFinished extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
    width: MediaQuery.sizeOf(context).width - 40,
    child: AnimatedGestureDetector(
      child: AnimatedColumn(
        fastAnimations: true,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ModerniAliasIcons.clap,
            height: 160,
          ),
          const SizedBox(height: 16),
          FadeInAnimation(
            curve: Curves.easeIn,
            duration: ModerniAliasDurations.slowAnimation,
            delay: ModerniAliasDurations.animation,
            child: Text(
              'gameFinished'.tr(),
              style: ModerniAliasTextStyles.gameOffStart,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
