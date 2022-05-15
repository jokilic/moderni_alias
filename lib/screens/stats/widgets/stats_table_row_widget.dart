import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_styles.dart';

class StatsTableRowWidget extends StatelessWidget {
  final String text;
  final int value;
  final bool bigText;

  const StatsTableRowWidget({
    required this.text,
    required this.value,
    this.bigText = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 8.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: ModerniAliasTextStyles.stats.copyWith(
                fontSize: bigText ? 24.sp : null,
              ),
            ),
            Text(
              '$value',
              style: ModerniAliasTextStyles.stats.copyWith(
                fontSize: bigText ? 24.sp : null,
              ),
            ),
          ],
        ),
      );
}
