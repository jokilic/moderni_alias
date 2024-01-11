import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => goToHowToPlayScreen(context),
        end: 0.8,
        child: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.question_mark_rounded,
            color: ModerniAliasColors.white,
          ),
          iconSize: 36,
        ),
      );
}
