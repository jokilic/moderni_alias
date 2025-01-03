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

  PlayedWord copyWith({
    String? word,
    Answer? chosenAnswer,
  }) =>
      PlayedWord(
        word: word ?? this.word,
        chosenAnswer: chosenAnswer ?? this.chosenAnswer,
      );

  @override
  String toString() => 'PlayedWord(word: $word, chosenAnswer: $chosenAnswer)';
}
