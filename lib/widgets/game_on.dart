import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../constants/durations.dart';
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
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        CircularCountDownTimer(
          strokeCap: StrokeCap.round,
          duration: length,
          width: size.width * 0.9,
          height: size.height * 0.6,
          onComplete: onComplete,
          ringColor: Colors.transparent,
          fillColor: fillColor,
          strokeWidth: 36,
          textStyle: ModerniAliasTextStyles.gameCircularCountdown,
        ),
        SizedBox(
          width: size.width - 40,
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
}
