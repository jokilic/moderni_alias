import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../models/dictionary.dart';

class GameOn extends StatelessWidget {
  final int length;
  final Function() onComplete;

  const GameOn({
    required this.length,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          CircularCountDownTimer(
            duration: length,
            width: 0.9.sw,
            height: 0.6.sh,
            onComplete: onComplete,
            ringColor: darkBlueColor,
            fillColor: countdownTimerFillColor,
            strokeWidth: 36.w,
            textStyle: const TextStyle(
              color: Colors.transparent,
            ),
          ),
          SizedBox(
            width: 1.sw - 40.w,
            child: FittedBox(
              child: Text(
                currentWord?.toUpperCase() ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8.w,
                    ),
              ),
            ),
          ),
        ],
      );
}
