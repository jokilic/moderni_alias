import 'dart:convert';

import 'package:hive_ce/hive.dart';

import '../../constants/enums.dart';

part 'played_word.g.dart';

@HiveType(typeId: 5)
class PlayedWord extends HiveObject {
  @HiveField(1)
  String word;

  @HiveField(2)
  Answer chosenAnswer;

  PlayedWord({
    required this.word,
    required this.chosenAnswer,
  });

  @override
  String toString() => 'PlayedWord(word: $word, chosenAnswer: $chosenAnswer)';

  Map<String, dynamic> toMap() => <String, dynamic>{
        'word': word,
        'chosenAnswer': chosenAnswer.name,
      };

  String toJson() => json.encode(toMap());
}
