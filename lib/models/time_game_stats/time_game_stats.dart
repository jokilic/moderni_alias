import 'package:hive/hive.dart';

import '../../constants/enums.dart';
import '../round/round.dart';
import '../team/team.dart';

part 'time_game_stats.g.dart';

@HiveType(typeId: 8)
class TimeGameStats extends HiveObject {
  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final DateTime endTime;

  @HiveField(3)
  final List<Team> teams;

  @HiveField(4)
  final List<Round> rounds;

  @HiveField(5)
  final Flag language;

  TimeGameStats({
    required this.startTime,
    required this.endTime,
    required this.teams,
    required this.rounds,
    required this.language,
  });

  TimeGameStats copyWith({
    DateTime? startTime,
    DateTime? endTime,
    List<Team>? teams,
    List<Round>? rounds,
    Flag? language,
  }) =>
      TimeGameStats(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        teams: teams ?? this.teams,
        rounds: rounds ?? this.rounds,
        language: language ?? this.language,
      );

  @override
  String toString() => 'TimeGameStats(startTime: $startTime, endTime: $endTime, teams: $teams, rounds: $rounds, language: $language)';
}
