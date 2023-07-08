import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import 'game_button.dart';

Widget createNumberOfTeamsButton({
  required String value,
  required Function() onTap,
  required bool isActive,
}) =>
    GameButton(
      backgroundColor: isActive ? ModerniAliasColors.whiteColor : Colors.transparent,
      color: isActive ? ModerniAliasColors.darkBlueColor : ModerniAliasColors.whiteColor,
      fontSize: 36,
      horizontalPadding: 20,
      value: value,
      onTap: onTap,
      size: 90,
    );
