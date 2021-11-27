import 'package:flutter/material.dart';

import './generic_button.dart';
import '../../../colors.dart';
import '../start_game_screen.dart';

Widget createNumberOfPointsButton({
  required int chosenNumberOfPoints,
  required Function() updateValue,
}) =>
    GenericButton(
      backgroundColor: pointsToWin == chosenNumberOfPoints ? whiteColor : Colors.transparent,
      color: pointsToWin == chosenNumberOfPoints ? darkBlueColor : whiteColor,
      fontSize: 24,
      horizontalPadding: 12,
      number: chosenNumberOfPoints,
      onTap: updateValue,
      size: 80,
    );
