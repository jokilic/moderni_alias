import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../constants/text_styles.dart';

class StatsTitleButton extends StatelessWidget {
  final String text;
  final double horizontalPadding;
  final double verticalPadding;
  final bool activeIcon;
  final Function() onPressed;

  const StatsTitleButton({
    required this.text,
    required this.onPressed,
    this.activeIcon = false,
    this.horizontalPadding = 24,
    this.verticalPadding = 16,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.w / 4,
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: ModerniAliasColors.whiteColor,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.w,
              vertical: verticalPadding.h,
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
                  style: ModerniAliasTextStyles.gameTitleSmall,
                ),
              ),
              AnimatedRotation(
                duration: ModerniAliasDurations.fastAnimation,
                curve: Curves.easeIn,
                turns: activeIcon ? 90 / 360 : 0,
                child: Icon(
                  Icons.play_arrow_rounded,
                  size: 24.r,
                  color: ModerniAliasColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      );
}
