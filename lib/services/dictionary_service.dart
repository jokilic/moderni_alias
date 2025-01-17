import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/enums.dart';
import '../dictionary/croatian/adjectives.dart';
import '../dictionary/croatian/nouns.dart';
import '../dictionary/croatian/special.dart';
import '../dictionary/croatian/verbs.dart';
import '../dictionary/english/adjectives.dart';
import '../dictionary/english/nouns.dart';
import '../dictionary/english/verbs.dart';
import '../models/used_words/used_words.dart';
import '../util/capitalize_string.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class DictionaryService extends ValueNotifier<Flag> {
  final LoggerService logger;
  final HiveService hive;

  DictionaryService({
    required this.logger,
    required this.hive,
  }) : super(Flag.croatia);

  ///
  /// VARIABLES
  ///

  late final random = Random();

  /// [Set] to track used `words`
  late Set<String> usedCroatianWords;
  late Set<String> usedEnglishWords;

  /// Dictionary containing croatian words
  final croatianDictionary = [
    ...imenice,
    ...glagoli,
    ...pridjevi,
    ...specijalne,
  ];

  /// Dictionary containing english words
  final englishDictionary = [
    ...nouns,
    ...verbs,
    ...adjectives,
  ];

  /// Active dictionary
  var currentDictionary = <String>[];

  ///
  /// INIT
  ///

  void init() {
    /// Load `usedWords` from [Hive]
    final usedWords = hive.getUsedWords();
    usedCroatianWords = Set.from(usedWords.croatianWords);
    usedEnglishWords = Set.from(usedWords.englishWords);

    /// Initialize `currentDictionary` excluding used words
    currentDictionary = [...croatianDictionary]..removeWhere(
        (word) => usedCroatianWords.contains(word),
      );
  }

  ///
  /// METHODS
  ///

  /// Remove used word from the `currentDictionary` and generate a new random word
  String getRandomWord({required String? previousWord}) {
    /// Remove previous word if it exists
    if (previousWord != null) {
      /// Remove from `currentDictionary`
      currentDictionary.remove(previousWord);
    }

    /// Refill only when dictionary is empty
    if (currentDictionary.isEmpty) {
      resetDictionary();
    }

    /// Generate new randomized word
    return currentDictionary[random.nextInt(currentDictionary.length)];
  }

  /// If there are no more words in the [currentDictionary], reset it
  void resetDictionary() {
    /// Clear [Set] of used words
    usedCroatianWords.clear();
    usedEnglishWords.clear();

    /// Update `currentDictionary`
    currentDictionary = List.from(
      value == Flag.croatia ? croatianDictionary : englishDictionary,
    );

    /// Persist cleared state
    hive.saveUsedWords(
      UsedWords(
        croatianWords: usedCroatianWords.toList(),
        englishWords: usedEnglishWords.toList(),
      ),
    );
  }

  /// Triggered when the user chooses a [Flag]
  void updateActiveDictionary({required Flag newLanguage}) {
    value = newLanguage;
    resetDictionary();
  }

  /// Triggered when each round ends
  Future<void> updateUsedWords(List<String> playedWords) async {
    /// Add words to appropriate [Set] based on current language
    value == Flag.croatia ? usedCroatianWords.addAll(playedWords) : usedEnglishWords.addAll(playedWords);

    /// Persist to [Hive]
    await hive.saveUsedWords(
      UsedWords(
        croatianWords: usedCroatianWords.toList(),
        englishWords: usedEnglishWords.toList(),
      ),
    );
  }

  /// Take words from the dictionary and return a random team name
  String getRandomTeamName() {
    /// Random adjective
    final adjective = value == Flag.croatia ? pridjevi[random.nextInt(pridjevi.length)] : adjectives[random.nextInt(adjectives.length)];

    /// Random noun
    final noun = value == Flag.croatia ? imenice[random.nextInt(imenice.length)] : nouns[random.nextInt(nouns.length)];

    return capitalizeFirstLetter('$adjective $noun');
  }
}
