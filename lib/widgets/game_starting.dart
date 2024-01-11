import 'package:flutter/material.dart';

import '../constants/durations.dart';
import '../constants/text_styles.dart';

class GameStarting extends StatelessWidget {
  final String currentSecond;

  const GameStarting({
    required this.currentSecond,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.sizeOf(context).width - 40,
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
      );
}
