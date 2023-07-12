import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/round/round.dart';
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

  ///
  /// METHODS
  ///

  /// Return `true` if the passed round's duration is the same as the fastest round
  bool calculateRoundFastest({required Round passedRound, required Round fastestRound}) => (passedRound.durationSeconds ?? 0) <= (fastestRound.durationSeconds ?? 0);
}
