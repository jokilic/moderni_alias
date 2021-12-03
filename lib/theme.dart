import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/colors.dart';

ThemeData theme(BuildContext context) => ThemeData(
      primaryColor: ModerniAliasColors.blueColor,
      colorScheme: const ColorScheme.dark(
        background: ModerniAliasColors.blueColor,
      ),
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: ModerniAliasColors.blueColor,
      textTheme: GoogleFonts.senTextTheme(
        Theme.of(context).textTheme,
      ),
    );
