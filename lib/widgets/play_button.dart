import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

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
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: ModerniAliasColors.whiteColor,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding.w,
            vertical: verticalPadding.h,
          ),
          side: BorderSide(
            color: ModerniAliasColors.whiteColor,
            width: 2.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Text(
          text,
          style: ModerniAliasTextStyles.playButton,
        ),
      );
}
