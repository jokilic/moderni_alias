import 'package:hive/hive.dart';

part 'game_stats.g.dart';

@HiveType(typeId: 0)
class GameStats extends HiveObject {
  @HiveField(1)
  final int playedQuickGames;

  @HiveField(2)
  final int playedNormalGames;

  @HiveField(3)
  final int correctAnswersQuickGames;

  @HiveField(4)
  final int wrongAnswersQuickGames;

  @HiveField(5)
  final int correctAnswersNormalGames;

  @HiveField(6)
  final int wrongAnswersNormalGames;

  GameStats({
    required this.playedQuickGames,
    required this.playedNormalGames,
    required this.correctAnswersQuickGames,
    required this.wrongAnswersQuickGames,
    required this.correctAnswersNormalGames,
    required this.wrongAnswersNormalGames,
  });

  GameStats copyWith({
    int? playedQuickGames,
    int? playedNormalGames,
    int? correctAnswersQuickGames,
    int? wrongAnswersQuickGames,
    int? correctAnswersNormalGames,
    int? wrongAnswersNormalGames,
  }) =>
      GameStats(
        playedQuickGames: playedQuickGames ?? this.playedQuickGames,
        playedNormalGames: playedNormalGames ?? this.playedNormalGames,
        correctAnswersQuickGames: correctAnswersQuickGames ?? this.correctAnswersQuickGames,
        wrongAnswersQuickGames: wrongAnswersQuickGames ?? this.wrongAnswersQuickGames,
        correctAnswersNormalGames: correctAnswersNormalGames ?? this.correctAnswersNormalGames,
        wrongAnswersNormalGames: wrongAnswersNormalGames ?? this.wrongAnswersNormalGames,
      );

  @override
  String toString() =>
      'GameStats(playedQuickGames: $playedQuickGames, playedNormalGames: $playedNormalGames, correctAnswersQuickGames: $correctAnswersQuickGames, wrongAnswersQuickGames: $wrongAnswersQuickGames, correctAnswersNormalGames: $correctAnswersNormalGames, wrongAnswersNormalGames: $wrongAnswersNormalGames)';
}
