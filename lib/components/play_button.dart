import 'package:flutter/material.dart';

import '../strings.dart';

class PlayButton extends StatelessWidget {
  final Function onPressed;

  PlayButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 56.0,
          vertical: 20.0,
        ),
        child: Text(
          startButtonString.toUpperCase(),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: onPressed,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}
