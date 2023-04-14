import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';

class StatsValueWidget extends StatelessWidget {
  final String text;
  final int? value;
  final bool bigText;
  final bool yellowCircle;
  final Function()? onPressed;
  final bool valueLeft;

  const StatsValueWidget({
    required this.text,
    this.value,
    this.bigText = false,
    this.yellowCircle = false,
    this.valueLeft = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: AnimatedGestureDetector(
          onTap: onPressed,
          child: TextButton(
            onPressed: null,
            style: TextButton.styleFrom(
              foregroundColor: ModerniAliasColors.whiteColor,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (value != null && valueLeft) ...[
                  StatsValueContainer(
                    yellowCircle: yellowCircle,
                    value: value,
                    bigText: bigText,
                  ),
                  SizedBox(width: 20.w),
                ],
                Expanded(
                  child: Text(
                    text,
                    style: ModerniAliasTextStyles.stats.copyWith(
                      fontSize: bigText ? 24.sp : null,
                    ),
                  ),
                ),
                if (value != null && !valueLeft) ...[
                  SizedBox(width: 20.w),
                  StatsValueContainer(
                    yellowCircle: yellowCircle,
                    value: value,
                    bigText: bigText,
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
  final int? value;
  final bool bigText;

  const StatsValueContainer({
    required this.yellowCircle,
    required this.value,
    required this.bigText,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(6.r),
        constraints: BoxConstraints(
          minHeight: 36.r,
          minWidth: 36.r,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: yellowCircle ? ModerniAliasColors.yellowColor : ModerniAliasColors.whiteColor,
        ),
        child: Text(
          '$value',
          style: ModerniAliasTextStyles.statsNumber.copyWith(
            fontSize: bigText ? 24.sp : null,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
