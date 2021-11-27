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
        textColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
          side: BorderSide(
            color: whiteColor,
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
