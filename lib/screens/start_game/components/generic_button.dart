import 'package:flutter/material.dart';

import '../../../colors.dart';

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
          vertical: 36,
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: whiteColor,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(24),
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
