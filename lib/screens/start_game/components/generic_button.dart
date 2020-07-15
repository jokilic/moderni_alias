import 'package:flutter/material.dart';

import '../../../colors.dart';

class GenericButton extends StatelessWidget {
  final Function onTap;
  final int number;
  final Color color;
  final Color backgroundColor;
  final double horizontalPadding;
  final double fontSize;
  final double size;

  GenericButton({
    this.onTap,
    this.number,
    this.color,
    this.backgroundColor,
    this.horizontalPadding,
    this.fontSize,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 36.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Center(
            child: Text(
              number.toString(),
              style: Theme.of(context).textTheme.headline3.copyWith(
                    fontSize: fontSize,
                    color: color,
                  ),
            ),
          ),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: whiteColor,
              width: 4,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
            ),
          ),
        ),
      ),
    );
  }
}
