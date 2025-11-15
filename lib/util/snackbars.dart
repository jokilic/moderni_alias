import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

void showSnackbar(
  BuildContext context, {
  required String text,
  required String icon,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      content: Row(
        children: [
          const SizedBox(width: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              icon,
              height: 28,
              width: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: ModerniAliasTextStyles.snackbar,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: ModerniAliasColors.white,
          width: 2,
        ),
      ),
    ),
  );
}
