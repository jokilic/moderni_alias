import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class ExitGameButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ExitGameButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 2.h,
          ),
          side: BorderSide(
            color: ModerniAliasColors.whiteColor,
            width: 2.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 36.w,
            vertical: 16.h,
          ),
          child: Text(
            text.toUpperCase(),
            style: ModerniAliasTextStyles.exitButton,
          ),
        ),
      );
}
