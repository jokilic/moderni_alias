import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../../../colors.dart';
import '../../../strings.dart';

class GameOff extends StatelessWidget {
  final Function onTap;

  GameOff({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircularCountDownTimer(
            duration: 0,
            width: 400.0,
            height: 400.0,
            color: countdownTimerColor,
            fillColor: countdownTimerFillColor,
            strokeWidth: 36.0,
            textStyle: TextStyle(
              color: Colors.transparent,
            ),
          ),
          Column(
            children: <Widget>[
              SvgPicture.asset(
                clickImage,
                height: 136.0,
              ),
              Text(
                startGameOnPressString,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
