import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/hive_service.dart';

final settingsProvider = Provider.autoDispose<SettingsController>(
  (ref) => SettingsController(
    hive: ref.watch(hiveProvider),
  ),
  name: 'SettingsProvider',
);

class SettingsController {
  final HiveService hive;

  SettingsController({
    required this.hive,
  });
}
