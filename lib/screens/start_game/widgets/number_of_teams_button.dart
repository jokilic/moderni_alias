import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import 'game_button.dart';

Widget createNumberOfTeamsButton({
  required int chosenNumberOfTeams,
  required Function() updateValue,
  required bool isActive,
}) =>
    GameButton(
      backgroundColor: isActive ? ModerniAliasColors.whiteColor : Colors.transparent,
      color: isActive ? ModerniAliasColors.blueColor : ModerniAliasColors.whiteColor,
      fontSize: 36.r,
      horizontalPadding: 20.w,
      number: chosenNumberOfTeams,
      onTap: updateValue,
      size: 90.r,
    );
