import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
    onTap: () => openHowToPlay(context),
    child: IconButton(
      onPressed: null,
      icon: Image.asset(
        ModerniAliasIcons.howTo,
        color: ModerniAliasColors.white,
        height: 32,
        width: 32,
      ),
      iconSize: 32,
    ),
  );
}
