import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/quick_game_stats/quick_game_stats.dart';

final quickGameStatsProvider = Provider.autoDispose.family<QuickGameStatsController, QuickGameStats>(
  (ref, quickGameStats) => QuickGameStatsController(quickGameStats),
  name: 'QuickGameStatsProvider',
);

class QuickGameStatsController {
  ///
  /// CONSTRUCTOR
  ///

  final QuickGameStats quickGameStats;

  QuickGameStatsController(this.quickGameStats);
}
