import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class StatsTextIconWidget extends StatelessWidget {
  final String text;
  final String? icon;
  final bool isSVG;
  final double size;

  const StatsTextIconWidget({
    required this.text,
    this.icon,
    this.isSVG = false,
    this.size = 68,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: ModerniAliasTextStyles.stats,
              ),
            ),
            SizedBox(width: 28.w),
            if (icon != null)
              if (isSVG)
                SvgPicture.asset(
                  icon!,
                  width: size.w,
                  colorFilter: const ColorFilter.mode(
                    ModerniAliasColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                )
              else
                Image.asset(
                  icon!,
                  width: size.w,
                ),
          ],
        ),
      );
}
