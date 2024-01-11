import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/text_styles.dart';
import '../screens/normal_game/normal_game_controller.dart';
import '../screens/quick_game/quick_game_controller.dart';
import '../screens/time_game/time_game_controller.dart';
import '../util/providers.dart';
import '../util/routing.dart';
import './exit_game_button.dart';
import 'animated_column.dart';
import 'background_image.dart';

void disposeGames(BuildContext context, WidgetRef ref) {
  ref
    ..invalidate(normalGameProvider(context))
    ..invalidate(timeGameProvider)
    ..invalidate(quickGameProvider(context));

  ref.read(countdownPlayerProvider).stop();
  ref.read(backgroundImageProvider.notifier).revertBackground();

  goToHomeScreen(context);
}

Future<bool> exitGameModal(
  BuildContext context,
  WidgetRef ref, {
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
                exitGame: () => disposeGames(context, ref),
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
