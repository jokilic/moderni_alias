import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      fontSize: 24.r,
      horizontalPadding: 12.w,
      number: chosenLengthOfRound,
      onTap: updateValue,
      size: 80.r,
    );
