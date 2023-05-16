import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class NameOfTeam extends StatelessWidget {
  final String hintText;
  final Function(String value) onChanged;
  final TextInputAction textInputAction;

  const NameOfTeam({
    required this.hintText,
    required this.onChanged,
    required this.textInputAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 12,
        ),
        child: TextField(
          textInputAction: textInputAction,
          onChanged: onChanged,
          style: ModerniAliasTextStyles.teamNameTextField,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: buildInputBorder(),
            enabledBorder: buildInputBorder(),
            hintText: hintText,
            hintStyle: ModerniAliasTextStyles.nameOfTeamHint,
          ),
          cursorColor: ModerniAliasColors.whiteColor,
          cursorRadius: const Radius.circular(16),
          cursorWidth: 4,
        ),
      );
}

// Make Input Border
UnderlineInputBorder buildInputBorder() => const UnderlineInputBorder(
      borderSide: BorderSide(
        color: ModerniAliasColors.whiteColor,
        width: 2,
      ),
    );
