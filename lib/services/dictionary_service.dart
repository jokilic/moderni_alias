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
import '../util/capitalize_string.dart';
import 'logger_service.dart';

class DictionaryService extends ValueNotifier<Flag> {
  final LoggerService logger;

  DictionaryService({
    required this.logger,
  }) : super(Flag.croatia);

  ///
  /// VARIABLES
  ///

  late final random = Random();

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
    currentDictionary = [...croatianDictionary];
  }

  ///
  /// METHODS
  ///

  /// Remove used word from the `currentDictionary` and generate a new random word
  String getRandomWord({required String? previousWord}) {
    /// If there are no more words in the dictionary, refill it
    if (currentDictionary.length == 2) {
      refillCurrentDictionary();
    }

    /// Remove `previousWord` from `currentDictionary`
    currentDictionary.remove(previousWord);

    /// Generate new randomized `word` from `currentDictionary`
    final newWord = currentDictionary[random.nextInt(currentDictionary.length)];

    /// Return `newWord`
    return newWord;
  }

  /// If there are no more words in the [currentDictionary], refill it
  List<String> refillCurrentDictionary() => currentDictionary = List.from(value == Flag.croatia ? croatianDictionary : englishDictionary);

  /// Triggered when the user chooses a [Flag]
  void updateActiveDictionary({required Flag newLanguage}) {
    value = newLanguage;
    refillCurrentDictionary();
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
