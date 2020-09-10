import 'package:flutter/material.dart';

import '../../../colors.dart';
import './generic_button.dart';
import '../start_game_screen.dart';

Widget createNumberOfPointsButton({
  int chosenNumberOfPoints,
  Function updateValue,
}) {
  return GenericButton(
    backgroundColor:
        pointsToWin == chosenNumberOfPoints ? whiteColor : Colors.transparent,
    color: pointsToWin == chosenNumberOfPoints ? darkBlueColor : whiteColor,
    fontSize: 24.0,
    horizontalPadding: 12.0,
    number: chosenNumberOfPoints,
    onTap: updateValue,
    size: 80.0,
  );
}
