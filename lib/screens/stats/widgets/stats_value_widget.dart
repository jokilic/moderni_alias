import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';

class StatsValueWidget extends StatelessWidget {
  final String text;
  final int? value;
  final String? textValue;
  final bool bigText;
  final bool yellowCircle;
  final Function()? onPressed;
  final bool valueLeft;

  const StatsValueWidget({
    required this.text,
    this.value,
    this.textValue,
    this.bigText = false,
    this.yellowCircle = false,
    this.valueLeft = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AnimatedGestureDetector(
          onTap: onPressed,
          child: TextButton(
            onPressed: null,
            style: TextButton.styleFrom(
              foregroundColor: ModerniAliasColors.whiteColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (valueLeft && (value != null || textValue != null)) ...[
                  StatsValueContainer(
                    yellowCircle: yellowCircle,
                    value: value != null ? value.toString() : textValue ?? '',
                    bigText: bigText,
                    isNumber: value != null,
                  ),
                  const SizedBox(width: 20),
                ],
                Expanded(
                  child: Text(
                    text,
                    style: ModerniAliasTextStyles.stats.copyWith(
                      fontSize: bigText ? 24 : null,
                    ),
                  ),
                ),
                if (!valueLeft && (value != null || textValue != null)) ...[
                  const SizedBox(width: 20),
                  StatsValueContainer(
                    yellowCircle: yellowCircle,
                    value: value != null ? value.toString() : textValue ?? '',
                    bigText: bigText,
                    isNumber: value != null,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
}

class StatsValueContainer extends StatelessWidget {
  final bool yellowCircle;
  final String? value;
  final bool bigText;
  final bool isNumber;

  const StatsValueContainer({
    required this.yellowCircle,
    required this.value,
    required this.bigText,
    required this.isNumber,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(6),
        constraints: const BoxConstraints(
          minHeight: 36,
          minWidth: 36,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: isNumber ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isNumber ? null : BorderRadius.circular(100),
          color: yellowCircle ? ModerniAliasColors.yellowColor : ModerniAliasColors.whiteColor,
        ),
        child: Text(
          '$value',
          style: ModerniAliasTextStyles.statsNumber.copyWith(
            fontSize: bigText ? 24 : null,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
