import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './generic_button.dart';
import '../../../constants/colors.dart';
import '../start_game_screen.dart';

Widget createNumberOfTeamsButton({
  required int chosenNumberOfTeams,
  required Function() updateValue,
}) =>
    GenericButton(
      backgroundColor: numOfTeamsValue == chosenNumberOfTeams ? whiteColor : Colors.transparent,
      color: numOfTeamsValue == chosenNumberOfTeams ? darkBlueColor : whiteColor,
      fontSize: 36.r,
      horizontalPadding: 20.w,
      number: chosenNumberOfTeams,
      onTap: updateValue,
      size: 90.r,
    );
