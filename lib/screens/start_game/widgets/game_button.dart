import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';

class GameButton extends StatelessWidget {
  final Function() onTap;
  final String value;
  final Color color;
  final Color backgroundColor;
  final double horizontalPadding;
  final double fontSize;
  final double size;

  const GameButton({
    required this.onTap,
    required this.value,
    required this.color,
    required this.backgroundColor,
    required this.horizontalPadding,
    required this.fontSize,
    required this.size,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 36,
        ),
        child: AnimatedGestureDetector(
          onTap: onTap,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                  color: ModerniAliasColors.whiteColor,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  value,
                  style: ModerniAliasTextStyles.gameButton.copyWith(
                    fontSize: fontSize,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
