class Team {
  String name;
  int points;
  int correctPoints;
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
