import 'dart:convert';

import 'package:hive_ce/hive.dart';

import '../../constants/enums.dart';
import '../round/round.dart';
import '../team/team.dart';

part 'normal_game_stats.g.dart';

@HiveType(typeId: 1)
class NormalGameStats extends HiveObject {
  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final DateTime endTime;

  @HiveField(3)
  final List<Team> teams;

  @HiveField(4)
  final List<Round> rounds;

  @HiveField(5)
  final int lengthOfRound;

  @HiveField(6)
  final int pointsToWin;

  @HiveField(7)
  final Flag language;

  NormalGameStats({
    required this.startTime,
    required this.endTime,
    required this.teams,
    required this.rounds,
    required this.lengthOfRound,
    required this.pointsToWin,
    required this.language,
  });

  NormalGameStats copyWith({
    DateTime? startTime,
    DateTime? endTime,
    List<Team>? teams,
    List<Round>? rounds,
    int? lengthOfRound,
    int? pointsToWin,
    Flag? language,
  }) =>
      NormalGameStats(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        teams: teams ?? this.teams,
        rounds: rounds ?? this.rounds,
        lengthOfRound: lengthOfRound ?? this.lengthOfRound,
        pointsToWin: pointsToWin ?? this.pointsToWin,
        language: language ?? this.language,
      );

  @override
  String toString() =>
      'NormalGameStats(startTime: $startTime, endTime: $endTime, teams: $teams, rounds: $rounds, lengthOfRound: $lengthOfRound, pointsToWin: $pointsToWin, language: $language)';

  Map<String, dynamic> toMap() => <String, dynamic>{
        'startTime': startTime.millisecondsSinceEpoch,
        'endTime': endTime.millisecondsSinceEpoch,
        'teams': teams.map((x) => x.toMap()).toList(),
        'lengthOfRound': lengthOfRound,
        'pointsToWin': pointsToWin,
        'language': language.name,
        'rounds': rounds.map((x) => x.toMap()).toList(),
      };

  String toJson() => json.encode(toMap());
}
