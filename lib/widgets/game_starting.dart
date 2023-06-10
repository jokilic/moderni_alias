import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        CircularCountDownTimer(
          strokeCap: StrokeCap.round,
          duration: 3,
          width: size.width * 0.9,
          height: size.height * 0.6,
          onComplete: onComplete,
          ringColor: Colors.transparent,
          fillColor: Colors.transparent,
          strokeWidth: 36,
          textStyle: ModerniAliasTextStyles.gameCircularCountdown,
        ),
        SizedBox(
          width: size.width - 40,
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
}
