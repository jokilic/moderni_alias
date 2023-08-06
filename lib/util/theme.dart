import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

final theme = ThemeData(
  useMaterial3: true,
  primaryColor: ModerniAliasColors.darkBlueColor,
  colorScheme: const ColorScheme.dark(
    background: ModerniAliasColors.darkBlueColor,
  ),
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: ModerniAliasColors.darkBlueColor,
  fontFamily: 'Sen',
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      textStyle: ModerniAliasTextStyles.playButton.copyWith(
        color: ModerniAliasColors.whiteColor,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
      foregroundColor: ModerniAliasColors.whiteColor,
      disabledForegroundColor: ModerniAliasColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
);
