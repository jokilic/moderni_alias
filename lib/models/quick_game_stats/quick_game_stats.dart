import 'package:hive/hive.dart';

import '../../constants/enums.dart';
import '../round/round.dart';

part 'quick_game_stats.g.dart';

@HiveType(typeId: 2)
class QuickGameStats extends HiveObject {
  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final DateTime endTime;

  @HiveField(3)
  final Round round;

  @HiveField(4)
  final Flag language;

  QuickGameStats({
    required this.startTime,
    required this.endTime,
    required this.round,
    required this.language,
  });

  QuickGameStats copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Round? round,
    Flag? language,
  }) =>
      QuickGameStats(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        round: round ?? this.round,
        language: language ?? this.language,
      );

  @override
  String toString() => 'QuickGameStats(startTime: $startTime, endTime: $endTime, round: $round, language: $language)';
}
