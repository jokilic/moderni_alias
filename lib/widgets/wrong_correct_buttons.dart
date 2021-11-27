import 'package:flutter/material.dart';

import './game_button.dart';
import '../constants/strings.dart';

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
        children: <Widget>[
          GameButton(
            svgIconPath: wrongImage,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
            ),
            onTap: wrongChosen,
          ),
          GameButton(
            svgIconPath: correctImage,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
            ),
            onTap: correctChosen,
          ),
        ],
      );
}
