import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/enums.dart';
import '../constants/images.dart';
import '../models/normal_game_stats/normal_game_stats.dart';
import '../models/played_word/played_word.dart';
import '../models/quick_game_stats/quick_game_stats.dart';
import '../models/round/round.dart';
import '../models/settings/settings.dart';
import '../models/team/team.dart';
import '../models/time_game_stats/time_game_stats.dart';
import 'logger_service.dart';

final hiveProvider = Provider<HiveService>(
  (_) => throw UnimplementedError(),
  name: 'HiveProvider',
);

class HiveService {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;

  HiveService(this.logger);

  ///
  /// VARIABLES
  ///

  late final Box<NormalGameStats> normalGameStatsBox;
  late final Box<QuickGameStats> quickGameStatsBox;
  late final Box<TimeGameStats> timeGameStatsBox;
  late final Box<SettingsHive> settingsBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(NormalGameStatsAdapter())
      ..registerAdapter(QuickGameStatsAdapter())
      ..registerAdapter(TimeGameStatsAdapter())
      ..registerAdapter(TeamAdapter())
      ..registerAdapter(RoundAdapter())
      ..registerAdapter(PlayedWordAdapter())
      ..registerAdapter(AnswerAdapter())
      ..registerAdapter(FlagAdapter())
      ..registerAdapter(SettingsHiveAdapter());

    normalGameStatsBox = await Hive.openBox<NormalGameStats>('normalGameStatsBox');
    quickGameStatsBox = await Hive.openBox<QuickGameStats>('quickGameStatsBox');
    timeGameStatsBox = await Hive.openBox<TimeGameStats>('timeGameStatsBox');
    settingsBox = await Hive.openBox<SettingsHive>('settingsBox');
  }

  ///
  /// DISPOSE
  ///

  Future<void> dispose() async {
    await normalGameStatsBox.close();
    await quickGameStatsBox.close();
    await timeGameStatsBox.close();
    await settingsBox.close();

    await Hive.close();
  }

  ///
  /// METHODS
  ///

  /// Called to add a new [NormalGameStats] value to [Hive]
  Future<void> addNormalGameStatsToBox({required NormalGameStats normalGameStats}) async => normalGameStatsBox.add(normalGameStats);

  /// Called to get all [NormalGameStats] values from [Hive]
  List<NormalGameStats> getNormalGameStatsFromBox() => normalGameStatsBox.values.toList();

  /// Called to add a new [QuickGameStats] value to [Hive]
  Future<void> addQuickGameStatsToBox({required QuickGameStats quickGameStats}) async => quickGameStatsBox.add(quickGameStats);

  /// Called to get all [QuickGameStats] values from [Hive]
  List<QuickGameStats> getQuickGameStatsFromBox() => quickGameStatsBox.values.toList();

  /// Called to add a new [TimeGameStats] value to [Hive]
  Future<void> addTimeGameStatsToBox({required TimeGameStats timeGameStats}) async => timeGameStatsBox.add(timeGameStats);

  /// Called to get all [TimeGameStats] values from [Hive]
  List<TimeGameStats> getTimeGameStatsFromBox() => timeGameStatsBox.values.toList();

  /// Called to add a new `Settings` value to [Hive]
  Future<void> addSettingsToBox(SettingsHive settingsHive) async => settingsBox.put(0, settingsHive);

  /// Called to get `Settings` from [Hive]
  SettingsHive getSettingsFromBox() =>
      settingsBox.get(0) ??
      SettingsHive(
        background: ModerniAliasImages.starsStandard,
        useDynamicBackgrounds: true,
        useCircularTimer: false,
      );
}
