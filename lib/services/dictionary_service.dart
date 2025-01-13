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
import '../util/typedef.dart';
import 'logger_service.dart';

class DictionaryService extends ValueNotifier<DictionaryState> {
  final LoggerService logger;

  DictionaryService({
    required this.logger,
  }) : super((currentWord: '', chosenLanguage: Flag.croatia));

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

  var currentDictionary = <String>[];

  ///
  /// INIT
  ///

  void init() {
    currentDictionary = [...croatianDictionary];

    value = (
      currentWord: getRandomWord(),
      chosenLanguage: value.chosenLanguage,
    );
  }

  ///
  /// METHODS
  ///

  /// Remove used word from the `currentDictionary` and give a new random word
  String getRandomWord() {
    /// If there are no more words in the dictionary, refill it
    if (currentDictionary.length == 2) {
      refillCurrentDictionary();
    }

    /// Remove currently guessed `word` from `currentDictionary`
    currentDictionary.remove(value.currentWord);

    /// Generate new randomized `word` from `currentDictionary`
    final newWord = currentDictionary[random.nextInt(currentDictionary.length)];

    /// Update `state` with `newWord`
    value = (
      currentWord: newWord,
      chosenLanguage: value.chosenLanguage,
    );

    /// Return `newWord`
    return newWord;
  }

  /// If there are no more words in the [currentDictionary], refill it
  List<String> refillCurrentDictionary() => currentDictionary = value.chosenLanguage == Flag.croatia ? [...croatianDictionary] : [...englishDictionary];

  /// Triggered when the user chooses a [Flag]
  void updateActiveDictionary({required Flag newLanguage}) {
    value = (
      currentWord: value.currentWord,
      chosenLanguage: newLanguage,
    );

    refillCurrentDictionary();
  }

  /// Takes words from the dictionary and returns a random team name
  String getRandomTeamName() {
    /// Random adjective
    final adjective = value.chosenLanguage == Flag.croatia ? pridjevi[random.nextInt(pridjevi.length)] : adjectives[random.nextInt(adjectives.length)];

    /// Random noun
    final noun = value.chosenLanguage == Flag.croatia ? imenice[random.nextInt(imenice.length)] : nouns[random.nextInt(nouns.length)];

    return capitalizeFirstLetter('$adjective $noun');
  }
}
