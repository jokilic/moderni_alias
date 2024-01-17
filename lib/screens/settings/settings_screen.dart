import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import 'settings_controller.dart';
import 'widgets/settings_backgrounds.dart';
import 'widgets/settings_checkbox_tile.dart';

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
                    SettingsBackgrounds(
                      backgrounds: backgrounds,
                      activeBackground: activeBackground,
                      onPressed: (newBackground) => ref.read(backgroundImageProvider.notifier).changeBackground(
                            newBackground,
                            isTemporary: false,
                          ),
                    ),
                    const SizedBox(height: 40),
                    SettingsCheckboxTile(
                      onPressed: ref.read(settingsProvider.notifier).useDynamicBackgroundsPressed,
                      title: 'Dynamic backgrounds',
                      subtitle: 'During games, change background as time or words progress',
                      isActive: settings.useDynamicBackgrounds,
                    ),
                    const SizedBox(height: 16),
                    SettingsCheckboxTile(
                      onPressed: ref.read(settingsProvider.notifier).useCircularTimerPressed,
                      title: 'Circular timer',
                      subtitle: 'Use a circular timer which shows the remaining time in a round',
                      isActive: settings.useCircularTimer,
                    ),
                    const SizedBox(height: 16),
                    SettingsCheckboxTile(
                      onPressed: ref.read(settingsProvider.notifier).openMicrophoneSettings,
                      title: 'Recording audio',
                      subtitle: "Records rounds so you can replay them in 'Previous games'",
                    ),
                    SizedBox(
                      height: MediaQuery.paddingOf(context).bottom,
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
