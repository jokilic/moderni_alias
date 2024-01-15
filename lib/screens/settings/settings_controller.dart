import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = Provider<SettingsController>(
  (_) => SettingsController(),
  name: 'SettingsProvider',
);

class SettingsController {}
