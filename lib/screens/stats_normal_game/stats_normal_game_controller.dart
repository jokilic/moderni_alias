import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/normal_game_stats/normal_game_stats.dart';

final normalGameStatsProvider = Provider.autoDispose.family<StatsNormalGameController, NormalGameStats>(
  (ref, normalGameStats) => StatsNormalGameController(normalGameStats),
  name: 'NormalGameStatsProvider',
);

class StatsNormalGameController {
  ///
  /// CONSTRUCTOR
  ///

  final NormalGameStats normalGameStats;

  StatsNormalGameController(this.normalGameStats);
}
