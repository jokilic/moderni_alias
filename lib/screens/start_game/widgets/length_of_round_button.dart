import 'package:flutter/material.dart';

import './generic_button.dart';
import '../../../constants/colors.dart';
import '../start_game_screen.dart';

Widget createLengthOfRoundButton({
  required int chosenLengthOfRound,
  required Function() updateValue,
}) =>
    GenericButton(
      backgroundColor: lengthOfRound == chosenLengthOfRound ? whiteColor : Colors.transparent,
      color: lengthOfRound == chosenLengthOfRound ? darkBlueColor : whiteColor,
      fontSize: 24,
      horizontalPadding: 12,
      number: chosenLengthOfRound,
      onTap: updateValue,
      size: 80,
    );
