import 'package:flutter/material.dart';

import '../../../colors.dart';
import './generic_button.dart';
import '../start_game_screen.dart';

Widget createLengthOfRoundButton(
    int chosenLengthOfRound, Function updateValue) {
  return GenericButton(
    backgroundColor: lengthOfRound == chosenLengthOfRound
        ? Colors.white
        : Colors.transparent,
    color: lengthOfRound == chosenLengthOfRound ? darkColor : Colors.white,
    fontSize: 24.0,
    horizontalPadding: 12.0,
    number: chosenLengthOfRound,
    onTap: updateValue,
    size: 80.0,
  );
}
