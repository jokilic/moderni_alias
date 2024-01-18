import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';

class NameOfTeam extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final Function(String value) onChanged;
  final Function() randomizePressed;
  final TextInputAction textInputAction;

  const NameOfTeam({
    required this.hintText,
    required this.textEditingController,
    required this.onChanged,
    required this.randomizePressed,
    required this.textInputAction,
    Key? key,
  }) : super(key: key);

  // Make Input Border
  UnderlineInputBorder buildInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(
          color: ModerniAliasColors.white,
          width: 2,
        ),
      );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 12,
        ),
        child: TextField(
          controller: textEditingController,
          textInputAction: textInputAction,
          onChanged: onChanged,
          style: ModerniAliasTextStyles.teamNameTextField,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            suffixIcon: Focus(
              descendantsAreTraversable: false,
              descendantsAreFocusable: false,
              canRequestFocus: false,
              skipTraversal: true,
              child: IconButton(
                onPressed: randomizePressed,
                icon: Image.asset(
                  ModerniAliasIcons.diceImage,
                  color: ModerniAliasColors.white,
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            border: InputBorder.none,
            focusedBorder: buildInputBorder(),
            enabledBorder: buildInputBorder(),
            hintText: hintText,
            hintStyle: ModerniAliasTextStyles.nameOfTeamHint,
          ),
          cursorColor: ModerniAliasColors.white,
          cursorRadius: const Radius.circular(16),
          cursorWidth: 4,
        ),
      );
}
