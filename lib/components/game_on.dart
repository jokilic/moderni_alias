import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../colors.dart';
import '../models/dictionary.dart';
import '../screens/start_game/start_game_screen.dart';

class GameOn extends StatelessWidget {
  final Function onComplete;

  GameOn({this.onComplete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircularCountDownTimer(
            duration: lengthOfRound,
            width: 400.0,
            height: 400.0,
            onComplete: onComplete,
            color: countdownTimerColor,
            fillColor: countdownTimerFillColor,
            strokeWidth: 36.0,
            textStyle: TextStyle(
              color: Colors.transparent,
            ),
          ),
          Text(
            currentWord.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8.0,
                ),
          ),
        ],
      ),
    );
  }
}
