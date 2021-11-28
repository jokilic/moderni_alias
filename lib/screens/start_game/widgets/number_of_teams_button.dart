import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './generic_button.dart';
import '../../../constants/colors.dart';

Widget createNumberOfTeamsButton({
  required int chosenNumberOfTeams,
  required Function() updateValue,
  required bool isActive,
}) =>
    GenericButton(
      backgroundColor: isActive ? whiteColor : Colors.transparent,
      color: isActive ? darkBlueColor : whiteColor,
      fontSize: 36.r,
      horizontalPadding: 20.w,
      number: chosenNumberOfTeams,
      onTap: updateValue,
      size: 90.r,
    );
