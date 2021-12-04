import 'package:flutter/material.dart';

import 'constants/colors.dart';

ThemeData theme(BuildContext context) => ThemeData(
      primaryColor: ModerniAliasColors.blueColor,
      colorScheme: const ColorScheme.dark(
        background: ModerniAliasColors.blueColor,
      ),
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: ModerniAliasColors.blueColor,
      fontFamily: 'Sen',
    );
