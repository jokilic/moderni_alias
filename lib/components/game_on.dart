import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../colors.dart';
import '../models/dictionary.dart';

class GameOn extends StatelessWidget {
  final int length;
  final Function onComplete;

  GameOn({this.length, this.onComplete});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => null,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircularCountDownTimer(
            duration: length,
            width: size.width * 0.9,
            height: size.height * 0.6,
            onComplete: onComplete,
            color: darkBlueColor,
            fillColor: countdownTimerFillColor,
            strokeWidth: 36.0,
            textStyle: TextStyle(
              color: Colors.transparent,
            ),
          ),
          Container(
            width: size.width,
            child: Text(
              currentWord.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
