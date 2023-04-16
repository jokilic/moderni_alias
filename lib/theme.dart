import 'package:flutter/material.dart';

import 'constants/colors.dart';

final theme = ThemeData(
  useMaterial3: true,
  primaryColor: ModerniAliasColors.darkBlueColor,
  colorScheme: const ColorScheme.dark(
    background: ModerniAliasColors.darkBlueColor,
  ),
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: ModerniAliasColors.darkBlueColor,
  fontFamily: 'Sen',
);
