import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

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

  @HiveField(5)
  TextEditingController textEditingController;

  Team({
    required this.name,
    required this.textEditingController,
    this.points = 0,
    this.correctPoints = 0,
    this.wrongPoints = 0,
  });

  Team copyWith({
    String? name,
    int? points,
    int? correctPoints,
    int? wrongPoints,
    TextEditingController? textEditingController,
  }) =>
      Team(
        name: name ?? this.name,
        points: points ?? this.points,
        correctPoints: correctPoints ?? this.correctPoints,
        wrongPoints: wrongPoints ?? this.wrongPoints,
        textEditingController: textEditingController ?? this.textEditingController,
      );

  @override
  String toString() => 'Team(name: $name, points: $points, correctPoints: $correctPoints, wrongPoints: $wrongPoints, textEditingController: $textEditingController)';
}
