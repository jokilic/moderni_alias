import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import '../colors.dart';
import '../strings.dart';

class GameOff extends StatelessWidget {
  final Function() onTap;

  GameOff({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CircularCountDownTimer(
            duration: 0,
            width: size.width * 0.9,
            height: size.height * 0.6,
            ringColor: darkBlueColor,
            fillColor: countdownTimerFillColor,
            strokeWidth: 36.0,
            textStyle: TextStyle(color: Colors.transparent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
