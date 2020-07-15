import 'package:flutter/material.dart';

import '../colors.dart';

class PlayButton extends StatelessWidget {
  final String text;
  final double horizontalPadding;
  final double verticalPadding;
  final Function onPressed;

  PlayButton({
    this.text,
    this.horizontalPadding = 50.0,
    this.verticalPadding = 20.0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
      ),
      onPressed: onPressed,
      textColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color: whiteColor,
          width: 2.0,
        ),
      ),
    );
  }
}
