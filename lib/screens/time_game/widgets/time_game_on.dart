import 'package:flutter/material.dart';

import '../../../constants/durations.dart';
import '../../../constants/text_styles.dart';

class TimeGameOn extends StatelessWidget {
  final String currentWord;
  final String time;
  final String numberOfGuessedWords;

  const TimeGameOn({
    required this.currentWord,
    required this.time,
    required this.numberOfGuessedWords,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      alignment: Alignment.center,
      children: [
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
        Container(
          alignment: Alignment.bottomCenter,
          width: size.width * 0.9,
          height: size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                numberOfGuessedWords,
                style: ModerniAliasTextStyles.timeGameNumberOfWords,
              ),
              Text(
                time,
                style: ModerniAliasTextStyles.timeGameClock,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
