import 'dart:math';

import './dictionary/croatian/adjectives.dart';
import './dictionary/croatian/nouns.dart';
import './dictionary/croatian/verbs.dart';
// import './dictionary/croatian/special.dart';

String currentWord = '';

const List<String> dictionary = [
  ...imenice,
  ...glagoli,
  ...pridjevi,
  // ...specijalne,
];

List<String> currentDictionary = [...dictionary];

List<String> refillCurrentDictionary() => currentDictionary = [...dictionary];

String setRandomWord(currentDictionary) {
  if (currentDictionary.length == 2) refillCurrentDictionary();

  currentDictionary.remove(currentWord);
  return currentWord =
      currentDictionary[Random().nextInt(currentDictionary.length)];
}

String get getRandomWord => setRandomWord(currentDictionary);
