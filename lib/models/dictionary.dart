import 'dart:math';

import './dictionary/croatian/adjectives.dart';
import './dictionary/croatian/nouns.dart';
import './dictionary/croatian/verbs.dart';
// import './dictionary/croatian/special.dart';

import './dictionary/english/adjectives.dart';
import './dictionary/english/nouns.dart';
import './dictionary/english/verbs.dart';
import '../screens/start_game/start_game_screen.dart';
import '../widgets/flag_button.dart';

String? currentWord = '';

const List<String> croatianDictionary = [
  ...imenice,
  ...glagoli,
  ...pridjevi,
  // ...specijalne,
];

const List<String> englishDictionary = [
  ...nouns,
  ...verbs,
  ...adjectives,
];

List<String> currentDictionary = [...croatianDictionary];

List<String> refillCurrentDictionary() => chosenDictionary == Flags.croatia
    ? currentDictionary = [...croatianDictionary]
    : currentDictionary = [...englishDictionary];

String setRandomWord(currentDictionary) {
  if (currentDictionary.length == 2) {
    refillCurrentDictionary();
  }

  currentDictionary.remove(currentWord);

  return currentWord = currentDictionary[Random().nextInt(currentDictionary.length)];
}

String? get getRandomWord => setRandomWord(currentDictionary);
