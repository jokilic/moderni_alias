import 'dart:convert';

import 'package:hive_ce/hive.dart';

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
  final int? durationSeconds;

  Round({
    required this.playedWords,
    this.playingTeam,
    this.audioRecording,
    this.durationSeconds,
  });

  @override
  String toString() => 'Round(playedWords: $playedWords, playingTeam: $playingTeam, audioRecording: $audioRecording, durationSeconds: $durationSeconds)';

  Map<String, dynamic> toMap() => <String, dynamic>{
        'playedWords': playedWords.map((x) => x.toMap()).toList(),
        'playingTeam': playingTeam?.toMap(),
        'durationSeconds': durationSeconds,
      };

  String toJson() => json.encode(toMap());
}
