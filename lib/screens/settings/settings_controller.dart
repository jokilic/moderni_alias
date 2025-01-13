import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import '../../models/settings/settings.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';

class SettingsController extends ValueNotifier<SettingsHive> {
  final LoggerService logger;
  final HiveService hive;

  SettingsController({
    required this.logger,
    required this.hive,
  }) : super(hive.getSettingsFromBox());

  ///
  /// METHODS
  ///

  /// Triggered when the user taps the `Dynamic backgrounds` button
  Future<void> useDynamicBackgroundsPressed() async {
    value = value.copyWith(
      useDynamicBackgrounds: !value.useDynamicBackgrounds,
    );

    await hive.addSettingsToBox(value);
  }

  /// Triggered when the user taps the `Circular timer` button
  Future<void> useCircularTimerPressed() async {
    value = value.copyWith(
      useCircularTimer: !value.useCircularTimer,
    );

    await hive.addSettingsToBox(value);
  }

  /// Opens phone microphone settings
  Future<void> openMicrophoneSettings() async => AppSettings.openAppSettings();
}
