import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/enums.dart';
import '../dictionary/croatian/adjectives.dart';
import '../dictionary/croatian/nouns.dart';
import '../dictionary/croatian/special.dart';
import '../dictionary/croatian/verbs.dart';
import '../dictionary/english/adjectives.dart';
import '../dictionary/english/nouns.dart';
import '../dictionary/english/verbs.dart';
import 'game_service.dart';
import 'logger_service.dart';

final dictionaryProvider = Provider<DictionaryService>(
  (ref) => DictionaryService(
    ref.watch(loggerProvider),
  ),
);

class DictionaryService {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;

  DictionaryService(this.logger);

  ///
  /// REACTIVE VARIABLES
  ///

  /// The currently used word in game
  final _currentWord = ''.obs;
  String get currentWord => _currentWord.value;
  set currentWord(String value) => _currentWord.value = value;

  ///
  /// VARIABLES
  ///

  late final Random random;

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

  String get getRandomWord => setRandomWord(currentDictionary);

  ///
  /// INIT
  ///

  @override
  void onInit() {
    super.onInit();

    initValues();
  }

  ///
  /// METHODS
  ///

  /// Initializes dictionary and Random
  void initValues() {
    currentDictionary = [...croatianDictionary];
    random = Random();
  }

  /// If there are no more words in the [currentDictionary], refill it
  List<String> refillCurrentDictionary() =>
      Get.find<GameService>().chosenDictionary == Flag.croatia ? currentDictionary = [...croatianDictionary] : currentDictionary = [...englishDictionary];

  /// Remove used word from the dictionary and give a new random word
  String setRandomWord(List<String> currentDictionary) {
    /// If there are no more words in the dictionary, refill it
    if (currentDictionary.length == 2) {
      refillCurrentDictionary();
    }

    /// Remove currently guessed word from the dictionary
    currentDictionary.remove(currentWord);

    /// Return randomized word from the dictionary
    return currentWord = currentDictionary[random.nextInt(currentDictionary.length)];
  }
}
