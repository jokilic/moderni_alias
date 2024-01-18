import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => goToHowToPlayScreen(context),
        end: 0.8,
        child: IconButton(
          onPressed: null,
          icon: Image.asset(
            ModerniAliasIcons.howToImage,
            color: ModerniAliasColors.white,
            height: 34,
            width: 34,
          ),
          iconSize: 34,
        ),
      );
}
