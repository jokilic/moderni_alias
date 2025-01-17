import 'package:hive_ce/hive.dart';

part 'used_words.g.dart';

@HiveType(typeId: 10)
class UsedWords extends HiveObject {
  @HiveField(0)
  final List<String> croatianWords;

  @HiveField(1)
  final List<String> englishWords;

  UsedWords({
    required this.croatianWords,
    required this.englishWords,
  });

  UsedWords copyWith({
    List<String>? croatianWords,
    List<String>? englishWords,
  }) =>
      UsedWords(
        croatianWords: croatianWords ?? this.croatianWords,
        englishWords: englishWords ?? this.englishWords,
      );

  @override
  String toString() => 'UsedWords(croatianWords: $croatianWords, englishWords: $englishWords)';
}
