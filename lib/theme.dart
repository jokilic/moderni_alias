import 'package:flutter/material.dart';

import 'constants/colors.dart';

final theme = ThemeData(
  primaryColor: darkBlueColor,
  colorScheme: const ColorScheme.dark(
    background: darkBlueColor,
  ),
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: darkBlueColor,
  fontFamily: 'Sen',
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: whiteColor,
      fontSize: 50,
    ),
    headline2: TextStyle(
      color: whiteColor,
      fontSize: 34,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: whiteColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    headline6: TextStyle(
      color: whiteColor,
      fontSize: 54,
      fontWeight: FontWeight.bold,
      letterSpacing: 8,
    ),
    bodyText1: TextStyle(
      color: whiteColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: whiteColor,
      fontSize: 14,
    ),
    headline4: TextStyle(
      color: whiteColor,
      fontSize: 20,
      height: 1.4,
    ),
    button: TextStyle(
      color: whiteColor,
    ),
  ),
);
