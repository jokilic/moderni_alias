import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';

class GenericButton extends StatelessWidget {
  final Function() onTap;
  final int number;
  final Color color;
  final Color backgroundColor;
  final double horizontalPadding;
  final double fontSize;
  final double size;

  const GenericButton({
    required this.onTap,
    required this.number,
    required this.color,
    required this.backgroundColor,
    required this.horizontalPadding,
    required this.fontSize,
    required this.size,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 36.h,
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: ModerniAliasColors.whiteColor,
                width: 4.w,
              ),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: fontSize,
                      color: color,
                    ),
              ),
            ),
          ),
        ),
      );
}
