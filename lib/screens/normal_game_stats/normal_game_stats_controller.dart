import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/normal_game_stats/normal_game_stats.dart';

final normalGameStatsProvider = Provider.autoDispose.family<NormalGameStatsController, NormalGameStats>(
  (ref, normalGameStats) => NormalGameStatsController(normalGameStats),
  name: 'NormalGameStatsProvider',
);

class NormalGameStatsController {
  ///
  /// CONSTRUCTOR
  ///

  final NormalGameStats normalGameStats;

  NormalGameStatsController(this.normalGameStats);
}
