import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';

class GameOff extends StatelessWidget {
  final Function() onTap;

  const GameOff({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            strokeWidth: 36,
            textStyle: const TextStyle(
              color: Colors.transparent,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                clickImage,
                height: 136,
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
