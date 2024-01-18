import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'animated_gesture_detector.dart';

class PlayButton extends StatelessWidget {
  final String text;
  final double horizontalPadding;
  final double verticalPadding;
  final Function() onPressed;

  const PlayButton({
    required this.text,
    required this.onPressed,
    this.horizontalPadding = 50,
    this.verticalPadding = 20,
  });

  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: onPressed,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            side: const BorderSide(
              color: ModerniAliasColors.white,
              width: 4,
            ),
          ),
          child: Text(text),
        ),
      );
}
