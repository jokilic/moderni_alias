import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import 'game_button.dart';

Widget createLengthOfRoundButton({
  required int chosenLengthOfRound,
  required Function() updateValue,
  required bool isActive,
}) =>
    GameButton(
      backgroundColor: isActive ? ModerniAliasColors.whiteColor : Colors.transparent,
      color: isActive ? ModerniAliasColors.darkBlueColor : ModerniAliasColors.whiteColor,
      fontSize: 24,
      horizontalPadding: 12,
      number: chosenLengthOfRound,
      onTap: updateValue,
      size: 80,
    );
