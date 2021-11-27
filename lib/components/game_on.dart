import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../models/dictionary.dart';

class GameOn extends StatelessWidget {
  final int length;
  final Function() onComplete;

  const GameOn({
    required this.length,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircularCountDownTimer(
          duration: length,
          width: size.width * 0.9,
          height: size.height * 0.6,
          onComplete: onComplete,
          ringColor: darkBlueColor,
          fillColor: countdownTimerFillColor,
          strokeWidth: 36,
          textStyle: const TextStyle(
            color: Colors.transparent,
          ),
        ),
        SizedBox(
          width: size.width - 40.0,
          child: FittedBox(
            child: Text(
              currentWord.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
