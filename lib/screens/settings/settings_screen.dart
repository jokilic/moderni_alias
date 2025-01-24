import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../services/background_image_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../util/dependencies.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
import 'settings_controller.dart';
import 'widgets/settings_backgrounds.dart';
import 'widgets/settings_checkbox_tile.dart';

class SettingsScreen extends WatchingStatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<SettingsController>(
      () => SettingsController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
      ),
    );
  }

  @override
  void dispose() {
    unregisterIfInitialized<SettingsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = watchIt<SettingsController>().value;
    final activeBackground = watchIt<BackgroundImageService>().value;

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
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimatedGestureDetector(
                        onTap: Navigator.of(context).pop,
                        end: 0.8,
                        child: IconButton(
                          onPressed: null,
                          icon: Transform.rotate(
                            angle: pi,
                            child: Image.asset(
                              ModerniAliasIcons.arrowStatsImage,
                              color: ModerniAliasColors.white,
                              height: 26,
                              width: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    HeroTitle(smallText: 'settingsTitle'.tr()),
                    const SizedBox(height: 64),
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
                      backgrounds: getIt.get<BackgroundImageService>().backgrounds,
                      activeBackground: activeBackground,
                      onPressed: (newBackground) => getIt.get<BackgroundImageService>().changeBackground(
                            newBackground,
                            isTemporary: false,
                          ),
                    ),
                    const SizedBox(height: 56),
                    SettingsCheckboxTile(
                      onPressed: getIt.get<SettingsController>().useDynamicBackgroundsPressed,
                      title: 'settingsDynamicBackgroundsTitle'.tr(),
                      subtitle: 'settingsDynamicBackgroundsSubtitle'.tr(),
                      isActive: settings.useDynamicBackgrounds,
                    ),
                    const SizedBox(height: 16),
                    SettingsCheckboxTile(
                      onPressed: getIt.get<SettingsController>().useCircularTimerPressed,
                      title: 'settingsCircularTimerTitle'.tr(),
                      subtitle: 'settingsCircularTimerSubtitle'.tr(),
                      isActive: settings.useCircularTimer,
                    ),
                    const SizedBox(height: 16),
                    SettingsCheckboxTile(
                      onPressed: getIt.get<SettingsController>().openMicrophoneSettings,
                      title: 'settingsRecordingAudioTitle'.tr(),
                      subtitle: 'settingsRecordingAudioSubtitle'.tr(),
                    ),
                    const SizedBox(height: 40),
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
