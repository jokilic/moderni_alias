import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/images.dart';
import '../constants/text_styles.dart';
import './exit_game_button.dart';
import 'animated_column.dart';

Future<bool> exitGameModal(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 36,
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
          Text(
            'exitModalQuestionString'.tr(),
            textAlign: TextAlign.center,
            style: ModerniAliasTextStyles.exitModal,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ExitGameButton(
                text: 'exitModalQuestionYes'.tr(),
              ),
              const SizedBox(width: 24),
              ExitGameButton(
                text: 'exitModalQuestionNo'.tr(),
                onPressed: Navigator.of(context).pop,
              ),
            ],
          ),
        ],
      ),
    ),
  );

  return false;
}
