import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/strings.dart';
import '../constants/text_styles.dart';

class GameOn extends StatelessWidget {
  final String currentWord;
  final Color fillColor;
  final int length;
  final Function() onComplete;

  const GameOn({
    required this.currentWord,
    required this.fillColor,
    required this.length,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          CircularCountDownTimer(
            strokeCap: StrokeCap.round,
            duration: length,
            width: 0.9.sw,
            height: 0.6.sh,
            onComplete: onComplete,
            ringColor: Colors.transparent,
            fillColor: fillColor,
            strokeWidth: 36.w,
            textStyle: ModerniAliasTextStyles.gameCircularCountdown,
          ),
          SizedBox(
            width: 1.sw - 40.w,
            child: FittedBox(
              child: AnimatedSize(
                duration: ModerniAliasDurations.veryFastAnimation,
                curve: Curves.easeIn,
                child: Text(
                  currentWord.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: ModerniAliasTextStyles.gameCurrentWord,
                ),
              ),
            ),
          ),
        ],
      );
}
