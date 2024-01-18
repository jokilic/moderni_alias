import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/text_styles.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
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
                    const SizedBox(height: 50),
                    HeroTitle(smallText: 'settingsTitle'.tr()),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'settingsBackgroundTitle'.tr(),
                        style: ModerniAliasTextStyles.settingsBigTitle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'settingsBackgroundSubtitle'.tr(),
                        style: ModerniAliasTextStyles.settingsSubtitle,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SettingsBackgrounds(
                      backgrounds: backgrounds,
                      activeBackground: activeBackground,
                      onPressed: (newBackground) => ref.read(backgroundImageProvider.notifier).changeBackground(
                            newBackground,
                            isTemporary: false,
                          ),
                    ),
                    const SizedBox(height: 56),
                    SettingsCheckboxTile(
                      onPressed: ref.read(settingsProvider.notifier).useDynamicBackgroundsPressed,
                      title: 'settingsDynamicBackgroundsTitle'.tr(),
                      subtitle: 'settingsDynamicBackgroundsSubtitle'.tr(),
                      isActive: settings.useDynamicBackgrounds,
                    ),
                    const SizedBox(height: 16),
                    SettingsCheckboxTile(
                      onPressed: ref.read(settingsProvider.notifier).useCircularTimerPressed,
                      title: 'settingsCircularTimerTitle'.tr(),
                      subtitle: 'settingsCircularTimerSubtitle'.tr(),
                      isActive: settings.useCircularTimer,
                    ),
                    const SizedBox(height: 16),
                    SettingsCheckboxTile(
                      onPressed: ref.read(settingsProvider.notifier).openMicrophoneSettings,
                      title: 'settingsRecordingAudioTitle'.tr(),
                      subtitle: 'settingsRecordingAudioSubtitle'.tr(),
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
