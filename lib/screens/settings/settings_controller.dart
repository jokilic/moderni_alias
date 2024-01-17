import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/settings/settings.dart';
import '../../services/hive_service.dart';

final settingsProvider = StateNotifierProvider.autoDispose<SettingsController, SettingsHive>(
  (ref) => SettingsController(
    hive: ref.watch(hiveProvider),
  ),
  name: 'SettingsProvider',
);

class SettingsController extends StateNotifier<SettingsHive> {
  final HiveService hive;

  SettingsController({
    required this.hive,
  }) : super(hive.getSettingsFromBox());

  /// Triggered when the user taps the `Dynamic backgrounds` button
  Future<void> useDynamicBackgroundsPressed() async {
    state = state.copyWith(
      useDynamicBackgrounds: !state.useDynamicBackgrounds,
    );

    await hive.addSettingsToBox(state);
  }

  /// Triggered when the user taps the `Circular timer` button
  Future<void> useCircularTimerPressed() async {
    state = state.copyWith(
      useCircularTimer: !state.useCircularTimer,
    );

    await hive.addSettingsToBox(state);
  }
}
