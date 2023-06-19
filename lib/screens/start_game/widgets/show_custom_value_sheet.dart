import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_column.dart';

void showCustomValueSheet({
  required String title,
  required String hintText,
  required BuildContext context,
  required Function(String value) onValueSaved,
  bool dismissible = true,
}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: dismissible,
      builder: (context) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 36,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ModerniAliasImages.backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: AnimatedColumn(
          fastAnimations: true,
          mainAxisSize: MainAxisSize.min,
          children: [
            ///
            /// CURRENT SCORES
            ///
            Text(
              title,
              style: ModerniAliasTextStyles.scoresTitle,
            ),
            const SizedBox(height: 8),

            ///
            /// TEXT FIELD
            ///
            CustomValueTextField(
              textEditingController: TextEditingController(),
              onSubmitted: (value) {
                onValueSaved(value);
                Navigator.of(context).pop();
              },
              hintText: hintText,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );

class CustomValueTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String value) onSubmitted;
  final String hintText;

  const CustomValueTextField({
    required this.textEditingController,
    required this.onSubmitted,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  // Make Input Border
  UnderlineInputBorder buildInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(
          color: ModerniAliasColors.whiteColor,
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
          textInputAction: TextInputAction.done,
          onSubmitted: onSubmitted,
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
