import 'dart:convert';

class Team {
  String name;
  int points;

  Team({
    required this.name,
    this.points = 0,
  });

  Team copyWith({
    String? name,
    int? points,
  }) =>
      Team(
        name: name ?? this.name,
        points: points ?? this.points,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'points': points,
      };

  factory Team.fromMap(Map<String, dynamic> map) => Team(
        name: map['name'],
        points: map['points'],
      );

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) => Team.fromMap(json.decode(source));

  @override
  String toString() => 'Team(name: $name, points: $points)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Team && other.name == name && other.points == points;
  }

  @override
  int get hashCode => name.hashCode ^ points.hashCode;
}
