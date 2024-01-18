import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/durations.dart';
import '../constants/text_styles.dart';

class GameOn extends StatelessWidget {
  final String currentWord;
  final int length;
  final bool showCircularTimer;

  const GameOn({
    required this.currentWord,
    required this.length,
    required this.showCircularTimer,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        if (showCircularTimer)
          CircularCountDownTimer(
            strokeCap: StrokeCap.round,
            duration: length,
            width: size.width * 0.9,
            height: size.height * 0.6,
            ringColor: Colors.transparent,
            fillColor: ModerniAliasColors.white.withOpacity(0.7),
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
