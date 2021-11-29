import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class NameOfTeam extends StatelessWidget {
  final String hintText;
  final Function(String value) onChanged;

  const NameOfTeam({
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 12,
        ),
        child: TextField(
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: buildInputBorder(),
            enabledBorder: buildInputBorder(),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: whiteColor.withOpacity(0.6),
                ),
          ),
          cursorColor: whiteColor,
          cursorRadius: const Radius.circular(16),
          cursorWidth: 4,
        ),
      );
}

// Make Input Border
UnderlineInputBorder buildInputBorder() => const UnderlineInputBorder(
      borderSide: BorderSide(
        color: whiteColor,
        width: 2,
      ),
    );
