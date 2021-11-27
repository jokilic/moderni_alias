import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './generic_button.dart';
import '../../../constants/colors.dart';
import '../start_game_screen.dart';

Widget createNumberOfPointsButton({
  required int chosenNumberOfPoints,
  required Function() updateValue,
}) =>
    GenericButton(
      backgroundColor: pointsToWin == chosenNumberOfPoints ? whiteColor : Colors.transparent,
      color: pointsToWin == chosenNumberOfPoints ? darkBlueColor : whiteColor,
      fontSize: 24.r,
      horizontalPadding: 12.w,
      number: chosenNumberOfPoints,
      onTap: updateValue,
      size: 80.r,
    );
