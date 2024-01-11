import 'package:flutter/material.dart';

import '../constants/durations.dart';
import '../constants/text_styles.dart';

class GameOn extends StatelessWidget {
  final String currentWord;

  const GameOn({
    required this.currentWord,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.sizeOf(context).width - 40,
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
      );
}
