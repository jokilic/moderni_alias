import 'package:flutter/material.dart';

import '../../../colors.dart';
import './generic_button.dart';
import '../start_game_screen.dart';

Widget createNumberOfTeamsButton(
    int chosenNumberOfTeams, Function updateValue) {
  return GenericButton(
    backgroundColor: numOfTeamsValue == chosenNumberOfTeams
        ? Colors.white
        : Colors.transparent,
    color: numOfTeamsValue == chosenNumberOfTeams ? darkColor : Colors.white,
    fontSize: 36.0,
    horizontalPadding: 20.0,
    number: chosenNumberOfTeams,
    onTap: updateValue,
    size: 90.0,
  );
}
