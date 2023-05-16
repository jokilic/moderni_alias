import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../how_to_play/how_to_play_screen.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => Get.toNamed(
          HowToPlayScreen.routeName,
        ),
        end: 0.8,
        child: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.question_mark_rounded,
            color: ModerniAliasColors.whiteColor,
          ),
          iconSize: 36,
        ),
      );
}
