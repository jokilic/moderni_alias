import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants/text_styles.dart';
import '../services/background_image_service.dart';
import '../util/dependencies.dart';
import '../util/routing.dart';
import './exit_game_button.dart';
import 'animated_column.dart';

void disposeAndGoHome(BuildContext context) {
  getIt.get<BackgroundImageService>().revertBackground();
  openHome(context);
}

Future<bool> exitGameModal(
  BuildContext context, {
  required String backgroundImage,
}) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 36,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.vertical(
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
                exitGame: () => disposeAndGoHome(context),
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
