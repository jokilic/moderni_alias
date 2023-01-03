import 'package:hive/hive.dart';

part 'team.g.dart';

@HiveType(typeId: 3)
class Team extends HiveObject {
  @HiveField(1)
  String name;

  @HiveField(2)
  int points;

  @HiveField(3)
  int correctPoints;

  @HiveField(4)
  int wrongPoints;

  Team({
    required this.name,
    this.points = 0,
    this.correctPoints = 0,
    this.wrongPoints = 0,
  });

  Team copyWith({
    String? name,
    int? points,
    int? correctPoints,
    int? wrongPoints,
  }) =>
      Team(
        name: name ?? this.name,
        points: points ?? this.points,
        correctPoints: correctPoints ?? this.correctPoints,
        wrongPoints: wrongPoints ?? this.wrongPoints,
      );

  @override
  String toString() => 'Team(name: $name, points: $points, correctPoints: $correctPoints, wrongPoints: $wrongPoints)';
}
