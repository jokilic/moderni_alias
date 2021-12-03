import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './generic_button.dart';
import '../../../constants/colors.dart';

Widget createLengthOfRoundButton({
  required int chosenLengthOfRound,
  required Function() updateValue,
  required bool isActive,
}) =>
    GenericButton(
      backgroundColor: isActive ? ModerniAliasColors.whiteColor : Colors.transparent,
      color: isActive ? ModerniAliasColors.darkblueColor : ModerniAliasColors.whiteColor,
      fontSize: 24.r,
      horizontalPadding: 12.w,
      number: chosenLengthOfRound,
      onTap: updateValue,
      size: 80.r,
    );
