import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/text_styles.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import 'settings_controller.dart';
import 'widgets/settings_backgrounds_widget.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final activeBackground = ref.watch(backgroundImageProvider);
    final backgrounds = ref.watch(backgroundImageProvider.notifier).backgrounds;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const GameTitle('Background'),
                    const SizedBox(height: 20),
                    SettingsBackgroundsWidget(
                      backgrounds: backgrounds,
                      activeBackground: activeBackground,
                      onPressed: (newBackground) => ref.read(backgroundImageProvider.notifier).changeBackground(
                            newBackground,
                            isTemporary: false,
                          ),
                    ),
                    const SizedBox(height: 40),
                    AnimatedGestureDetector(
                      onTap: ref.read(settingsProvider.notifier).useDynamicBackgroundsPressed,
                      child: ListTile(
                        title: const Text(
                          'Dynamic backgrounds',
                          style: ModerniAliasTextStyles.settingsTitle,
                        ),
                        subtitle: const Text(
                          'During games, the background will be changed dynamically',
                          style: ModerniAliasTextStyles.settingsSubtitle,
                        ),
                        trailing: AnimatedContainer(
                          duration: ModerniAliasDurations.fastAnimation,
                          curve: Curves.easeIn,
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ModerniAliasColors.white,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: settings.useDynamicBackgrounds ? ModerniAliasColors.white : Colors.transparent,
                          ),
                          child: AnimatedOpacity(
                            opacity: settings.useDynamicBackgrounds ? 1 : 0,
                            duration: ModerniAliasDurations.fastAnimation,
                            curve: Curves.easeIn,
                            child: const Icon(
                              Icons.check_rounded,
                              color: ModerniAliasColors.darkBlue,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
