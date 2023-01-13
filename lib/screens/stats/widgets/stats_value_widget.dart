import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class StatsValueWidget extends StatelessWidget {
  final String text;
  final int? value;
  final bool bigText;
  final Function()? onPressed;

  const StatsValueWidget({
    required this.text,
    this.value,
    this.bigText = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: TextButton(
          onPressed: onPressed,
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
              Expanded(
                child: Text(
                  text,
                  style: ModerniAliasTextStyles.stats.copyWith(
                    fontSize: bigText ? 24.sp : null,
                  ),
                ),
              ),
              if (value != null) ...[
                SizedBox(width: 20.w),
                Text(
                  '$value',
                  style: ModerniAliasTextStyles.stats.copyWith(
                    fontSize: bigText ? 24.sp : null,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
}
