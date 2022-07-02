import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/strings.dart';
import '../constants/text_styles.dart';

class GameStarting extends StatelessWidget {
  final String currentSecond;
  final Function() onComplete;

  const GameStarting({
    required this.currentSecond,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          CircularCountDownTimer(
            strokeCap: StrokeCap.round,
            duration: 3,
            width: 0.9.sw,
            height: 0.6.sh,
            onComplete: onComplete,
            ringColor: Colors.transparent,
            fillColor: Colors.transparent,
            strokeWidth: 36.w,
            textStyle: ModerniAliasTextStyles.gameCircularCountdown,
          ),
          SizedBox(
            width: 1.sw - 40.w,
            child: AnimatedSwitcher(
              duration: ModerniAliasDurations.fastAnimation,
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Text(
                key: UniqueKey(),
                currentSecond,
                textAlign: TextAlign.center,
                style: ModerniAliasTextStyles.gameCurrentSecond,
              ),
            ),
          ),
        ],
      );
}
