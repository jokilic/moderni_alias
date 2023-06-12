import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/enums.dart';
import '../models/normal_game_stats/normal_game_stats.dart';
import '../models/played_word/played_word.dart';
import '../models/quick_game_stats/quick_game_stats.dart';
import '../models/round/round.dart';
import '../models/team/team.dart';
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

  HiveService(this.logger) {
    init();
  }

  ///
  /// VARIABLES
  ///

  late final Box<NormalGameStats> normalGameStatsBox;
  late final Box<QuickGameStats> quickGameStatsBox;

  ///
  /// INIT
  ///

  Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(NormalGameStatsAdapter())
      ..registerAdapter(QuickGameStatsAdapter())
      ..registerAdapter(TeamAdapter())
      ..registerAdapter(RoundAdapter())
      ..registerAdapter(PlayedWordAdapter())
      ..registerAdapter(AnswerAdapter())
      ..registerAdapter(FlagAdapter());

    normalGameStatsBox = await Hive.openBox<NormalGameStats>('normalGameStatsBox');
    quickGameStatsBox = await Hive.openBox<QuickGameStats>('quickGameStatsBox');
  }

  ///
  /// DISPOSE
  ///

  Future<void> dispose() async {
    await normalGameStatsBox.close();
    await quickGameStatsBox.close();
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
}
