import 'package:flutter/material.dart';

import 'constants/colors.dart';
import 'constants/text_styles.dart';

final theme = ThemeData(
  useMaterial3: true,
  primaryColor: ModerniAliasColors.darkBlue,
  colorScheme: const ColorScheme.dark(
    surface: ModerniAliasColors.darkBlue,
  ),
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: ModerniAliasColors.darkBlue,
  fontFamily: 'Sen',
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      textStyle: ModerniAliasTextStyles.playButton,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
      foregroundColor: ModerniAliasColors.white,
      disabledForegroundColor: ModerniAliasColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
);
