import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      fontSize: 24.r,
      horizontalPadding: 12.w,
      number: chosenLengthOfRound,
      onTap: updateValue,
      size: 80.r,
    );
