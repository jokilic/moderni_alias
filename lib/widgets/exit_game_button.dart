import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class ExitGameButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ExitGameButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: onPressed,
        textColor: ModerniAliasColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
          side: BorderSide(
            color: ModerniAliasColors.whiteColor,
            width: 2.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 36.w,
            vertical: 16.h,
          ),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 18.r,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
