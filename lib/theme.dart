import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/colors.dart';

final theme = ThemeData(
  primaryColor: darkBlueColor,
  colorScheme: const ColorScheme.dark(
    background: darkBlueColor,
  ),
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: darkBlueColor,
  fontFamily: 'Sen',
  textTheme: TextTheme(
    headline1: TextStyle(
      color: whiteColor,
      fontSize: 50.r,
    ),
    headline2: TextStyle(
      color: whiteColor,
      fontSize: 34.r,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: whiteColor,
      fontSize: 30.r,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: whiteColor,
      fontSize: 54.r,
      fontWeight: FontWeight.bold,
      letterSpacing: 8.w,
    ),
    bodyText1: TextStyle(
      color: whiteColor,
      fontSize: 22.r,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: whiteColor,
      fontSize: 14.r,
    ),
    headline4: TextStyle(
      color: whiteColor,
      fontSize: 20.r,
      height: 1.4.h,
    ),
    button: const TextStyle(
      color: whiteColor,
    ),
  ),
);
