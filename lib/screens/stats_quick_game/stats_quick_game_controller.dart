import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/quick_game_stats/quick_game_stats.dart';

final quickGameStatsProvider = Provider.autoDispose.family<StatsQuickGameController, QuickGameStats>(
  (ref, quickGameStats) => StatsQuickGameController(quickGameStats),
  name: 'QuickGameStatsProvider',
);

class StatsQuickGameController {
  ///
  /// CONSTRUCTOR
  ///

  final QuickGameStats quickGameStats;

  StatsQuickGameController(this.quickGameStats);
}
