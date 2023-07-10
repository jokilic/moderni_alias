import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/time_game_stats/time_game_stats.dart';

final timeGameStatsProvider = Provider.autoDispose.family<TimeGameStatsController, TimeGameStats>(
  (ref, timeGameStats) => TimeGameStatsController(timeGameStats),
  name: 'TimeGameStatsProvider',
);

class TimeGameStatsController {
  ///
  /// CONSTRUCTOR
  ///

  final TimeGameStats timeGameStats;

  TimeGameStatsController(this.timeGameStats);
}
