import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 9)
class SettingsHive extends HiveObject {
  @HiveField(1)
  final String background;

  @HiveField(2)
  final bool useDynamicBackgrounds;

  SettingsHive({
    required this.background,
    required this.useDynamicBackgrounds,
  });

  SettingsHive copyWith({
    String? background,
    bool? useDynamicBackgrounds,
  }) =>
      SettingsHive(
        background: background ?? this.background,
        useDynamicBackgrounds: useDynamicBackgrounds ?? this.useDynamicBackgrounds,
      );

  @override
  String toString() => 'SettingsHive(background: $background, useDynamicBackgrounds: $useDynamicBackgrounds)';
}
