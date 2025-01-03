import 'package:hive_ce/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 9)
class SettingsHive extends HiveObject {
  @HiveField(1)
  final String background;

  @HiveField(2)
  final bool useDynamicBackgrounds;

  @HiveField(3)
  final bool useCircularTimer;

  SettingsHive({
    required this.background,
    required this.useDynamicBackgrounds,
    required this.useCircularTimer,
  });

  SettingsHive copyWith({
    String? background,
    bool? useDynamicBackgrounds,
    bool? useCircularTimer,
  }) =>
      SettingsHive(
        background: background ?? this.background,
        useDynamicBackgrounds: useDynamicBackgrounds ?? this.useDynamicBackgrounds,
        useCircularTimer: useCircularTimer ?? this.useCircularTimer,
      );

  @override
  String toString() => 'SettingsHive(background: $background, useDynamicBackgrounds: $useDynamicBackgrounds, useCircularTimer: $useCircularTimer)';
}
