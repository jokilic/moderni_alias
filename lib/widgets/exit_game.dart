import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './exit_game_button.dart';
import '../constants/strings.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';

Future<bool> exitGameModal() async {
  await Get.bottomSheet(
    Container(
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
                animationController: gameService.exitButtonAnimationController,
                pointerDown: (_) => gameService.exitButtonAnimationController.forward(),
                pointerUp: (_) => gameService.exitButtonAnimationController.reverse(),
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

  /// Reset animation when dismissing modal
  gameService.exitButtonAnimationController.value = 0;
  return false;
}
