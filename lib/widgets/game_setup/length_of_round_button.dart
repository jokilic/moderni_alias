import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'game_button.dart';

Widget createLengthOfRoundButton({
  required String value,
  required Function() onTap,
  required bool isActive,
}) =>
    GameButton(
      backgroundColor: isActive ? ModerniAliasColors.white : Colors.transparent,
      color: isActive ? ModerniAliasColors.darkBlue : ModerniAliasColors.white,
      fontSize: 24,
      horizontalPadding: 12,
      value: value,
      onTap: onTap,
      size: 80,
    );
