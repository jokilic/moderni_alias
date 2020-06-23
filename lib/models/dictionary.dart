import 'dart:math';

import './dictionary/croatian/adjectives.dart';
import './dictionary/croatian/nouns.dart';
import './dictionary/croatian/special.dart';
import './dictionary/croatian/verbs.dart';

String currentWord = '';

const List<String> dictionary = [
  ...imenice,
  ...glagoli,
  ...pridjevi,
  ...specijalne,
];

String setRandomWord(dictionary) =>
    currentWord = dictionary[Random().nextInt(dictionary.length)];

String get getRandomWord => setRandomWord(dictionary);
