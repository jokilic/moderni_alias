import '../../models/round/round.dart';
import '../../models/time_game_stats/time_game_stats.dart';

final timeGameStatsProvider = Provider.autoDispose.family<StatsTimeGameController, TimeGameStats>(
  (ref, timeGameStats) => StatsTimeGameController(timeGameStats),
  name: 'TimeGameStatsProvider',
);

class StatsTimeGameController {
  ///
  /// CONSTRUCTOR
  ///

  final TimeGameStats timeGameStats;

  StatsTimeGameController(this.timeGameStats);

  ///
  /// METHODS
  ///

  /// Return `true` if the passed round's duration is the same as the fastest round
  bool calculateRoundFastest({required Round passedRound, required Round fastestRound}) => (passedRound.durationSeconds ?? 0) <= (fastestRound.durationSeconds ?? 0);
}
