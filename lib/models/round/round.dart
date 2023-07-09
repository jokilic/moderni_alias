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

  @HiveField(3)
  final String? audioRecording;

  @HiveField(4)
  final Duration? duration;

  Round({
    required this.playedWords,
    this.playingTeam,
    this.audioRecording,
    this.duration,
  });

  Round copyWith({
    List<PlayedWord>? playedWords,
    Team? playingTeam,
    String? audioRecording,
    Duration? duration,
  }) =>
      Round(
        playedWords: playedWords ?? this.playedWords,
        playingTeam: playingTeam ?? this.playingTeam,
        audioRecording: audioRecording ?? this.audioRecording,
        duration: duration ?? this.duration,
      );

  @override
  String toString() => 'Round(playedWords: $playedWords, playingTeam: $playingTeam, audioRecording: $audioRecording, duration: $duration)';
}
