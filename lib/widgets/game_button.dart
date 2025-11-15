import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'animated_gesture_detector.dart';

class GameButton extends StatelessWidget {
  final String iconPath;
  final BorderRadius borderRadius;
  final Function() onTap;

  const GameButton({
    required this.iconPath,
    required this.borderRadius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Expanded(
    child: AnimatedGestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(50),
        height: 150,
        decoration: BoxDecoration(
          color: ModerniAliasColors.white.withValues(alpha: 0.05),
          borderRadius: borderRadius,
        ),
        child: Image.asset(
          iconPath,
          color: ModerniAliasColors.white,
        ),
      ),
    ),
  );
}
