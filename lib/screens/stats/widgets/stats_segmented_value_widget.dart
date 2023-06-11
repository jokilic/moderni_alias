import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';

class StatsSegmentedValueWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool isActive;

  const StatsSegmentedValueWidget({
    required this.onPressed,
    required this.text,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: AnimatedGestureDetector(
          onTap: onPressed,
          child: TextButton(
            onPressed: null,
            style: TextButton.styleFrom(
              foregroundColor: ModerniAliasColors.whiteColor,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Column(
              children: [
                FittedBox(
                  child: Text(
                    text,
                    style: ModerniAliasTextStyles.statsSegmentedControl,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedOpacity(
                  opacity: isActive ? 1 : 0,
                  duration: ModerniAliasDurations.fastAnimation,
                  curve: Curves.easeIn,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ModerniAliasColors.whiteColor,
                    ),
                    height: 5,
                    width: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
