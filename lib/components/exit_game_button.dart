import 'package:flutter/material.dart';

import '../colors.dart';

class ExitGameButton extends StatelessWidget {
  final String? text;
  final Function? onPressed;

  ExitGameButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 36.0,
          vertical: 16.0,
        ),
        child: Text(
          text!.toUpperCase(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: onPressed as void Function()?,
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
