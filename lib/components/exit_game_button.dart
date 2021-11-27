import 'package:flutter/material.dart';

import '../colors.dart';

class ExitGameButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ExitGameButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: onPressed,
        textColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: whiteColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 36,
            vertical: 16,
          ),
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
