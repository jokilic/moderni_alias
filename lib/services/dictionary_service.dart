import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/enums.dart';
import '../dictionary/croatian/adjectives.dart';
import '../dictionary/croatian/nouns.dart';
import '../dictionary/croatian/special.dart';
import '../dictionary/croatian/verbs.dart';
import '../dictionary/english/adjectives.dart';
import '../dictionary/english/nouns.dart';
import '../dictionary/english/verbs.dart';
import '../util/capitalize_string.dart';
import '../util/providers.dart';
import 'logger_service.dart';

final chosenDictionaryProvider = StateProvider<Flag>(
  (_) => Flag.croatia,
  name: 'ChosenDictionaryProvider',
);

final dictionaryProvider = NotifierProvider<DictionaryNotifier, String>(
  DictionaryNotifier.new,
  name: 'DictionaryProvider',
);

class DictionaryNotifier extends Notifier<String> {
  @override
  String build() {
    init();
    state = '';
    return getRandomWord();
  }

  ///
  /// VARIABLES
  ///

  late final LoggerService logger;

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
    logger = ref.watch(loggerProvider);
    currentDictionary = [...croatianDictionary];
  }

  ///
  /// METHODS
  ///

  /// Returns a random word from the `currentDictionary`
  String getRandomWord() => setRandomWord(
        currentDictionary,
        chosenDictionary: ref.read(chosenDictionaryProvider),
      );

  /// If there are no more words in the [currentDictionary], refill it
  List<String> refillCurrentDictionary() =>
      ref.read(chosenDictionaryProvider) == Flag.croatia ? currentDictionary = [...croatianDictionary] : currentDictionary = [...englishDictionary];

  /// Remove used word from the dictionary and give a new random word
  String setRandomWord(List<String> currentDictionary, {required Flag chosenDictionary}) {
    /// If there are no more words in the dictionary, refill it
    if (currentDictionary.length == 2) {
      refillCurrentDictionary();
    }

    /// Remove currently guessed word from the dictionary
    currentDictionary.remove(state);

    /// Return randomized word from the dictionary
    return state = currentDictionary[ref.read(randomProvider).nextInt(currentDictionary.length)];
  }

  /// Takes words from the dictionary and returns a random team name
  String getRandomTeamName() {
    /// Random adjective
    final adjective = ref.read(chosenDictionaryProvider) == Flag.croatia
        ? pridjevi[ref.read(randomProvider).nextInt(pridjevi.length)]
        : adjectives[ref.read(randomProvider).nextInt(adjectives.length)];

    /// Random noun
    final noun =
        ref.read(chosenDictionaryProvider) == Flag.croatia ? imenice[ref.read(randomProvider).nextInt(imenice.length)] : nouns[ref.read(randomProvider).nextInt(nouns.length)];

    return capitalizeFirstLetter('$adjective $noun');
  }
}
