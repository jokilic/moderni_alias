import '../constants/enums.dart';

class PlayedWord {
  String word;
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
