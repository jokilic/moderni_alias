import 'package:flutter/material.dart';

import '../constants/icons.dart';
import './game_button.dart';

class WrongCorrectButtons extends StatelessWidget {
  final Function() wrongChosen;
  final Function() correctChosen;

  const WrongCorrectButtons({
    required this.wrongChosen,
    required this.correctChosen,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GameButton(
        iconPath: ModerniAliasIcons.wrong,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
        ),
        onTap: wrongChosen,
      ),
      GameButton(
        iconPath: ModerniAliasIcons.correct,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
        ),
        onTap: correctChosen,
      ),
    ],
  );
}
