import 'package:hive/hive.dart';

import '../played_word/played_word.dart';
import '../team/team.dart';

part 'round.g.dart';

@HiveType(typeId: 4)
class Round extends HiveObject {
  @HiveField(1)
  final List<PlayedWord> playedWords;

  @HiveField(2)
  final Team? playingTeam;

  Round({
    required this.playedWords,
    this.playingTeam,
  });

  Round copyWith({
    List<PlayedWord>? playedWords,
    Team? playingTeam,
  }) =>
      Round(
        playedWords: playedWords ?? this.playedWords,
        playingTeam: playingTeam ?? this.playingTeam,
      );

  @override
  String toString() => 'Round(playedWords: $playedWords, playingTeam: $playingTeam)';
}
