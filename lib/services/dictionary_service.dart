import 'dart:math';

import 'package:get/get.dart';

import '../constants/enums.dart';
import '../dictionary/croatian/adjectives.dart';
import '../dictionary/croatian/nouns.dart';
import '../dictionary/croatian/special.dart';
import '../dictionary/croatian/verbs.dart';
import '../dictionary/english/adjectives.dart';
import '../dictionary/english/nouns.dart';
import '../dictionary/english/verbs.dart';
import 'game_service.dart';

class DictionaryService extends GetxService {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  /// The currently used word in game
  final _currentWord = ''.obs;

  /// Dictionary containing croatian words
  final _croatianDictionary = [
    ...imenice,
    ...glagoli,
    ...pridjevi,
    ...specijalne,
  ].obs;

  /// Dictionary containing english words
  final _englishDictionary = [
    ...nouns,
    ...verbs,
    ...adjectives,
  ].obs;

  final _currentDictionary = <String>[].obs;

  late final Random _random;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  String get currentWord => _currentWord.value;
  List<String> get croatianDictionary => _croatianDictionary;
  List<String> get englishDictionary => _englishDictionary;
  List<String> get currentDictionary => _currentDictionary;
  Random get random => _random;

  String get getRandomWord => setRandomWord(currentDictionary);

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set currentWord(String value) => _currentWord.value = value;
  set croatianDictionary(List<String> value) => _croatianDictionary.assignAll(value);
  set englishDictionary(List<String> value) => _englishDictionary.assignAll(value);
  set currentDictionary(List<String> value) => _currentDictionary.assignAll(value);
  set random(Random value) => _random = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
    initValues();
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Initializes dictionary and Random
  void initValues() {
    currentDictionary = [...croatianDictionary];
    random = Random();
  }

  /// If there are no more words in the [currentDictionary], refill it
  List<String> refillCurrentDictionary() => Get.find<GameService>().chosenDictionary == Flags.croatia
      ? currentDictionary = [...croatianDictionary]
      : currentDictionary = [...englishDictionary];

  /// Remove used word from the dictionary and give a new random word
  String setRandomWord(currentDictionary) {
    if (currentDictionary.length == 2) {
      refillCurrentDictionary();
    }

    currentDictionary.remove(currentWord);

    return currentWord = currentDictionary[random.nextInt(currentDictionary.length)];
  }
}
