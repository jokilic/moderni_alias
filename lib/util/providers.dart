import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/strings.dart';
import '../models/played_word/played_word.dart';

final randomProvider = Provider<Random>(
  (_) => Random(),
  name: 'RandomProvider',
);
final correctPlayerProvider = Provider<AudioPlayer>(
  (_) => AudioPlayer()..setAsset(ModerniAliasSounds.correct, preload: false),
  name: 'CorrectPlayerProvider',
);
final wrongPlayerProvider = Provider<AudioPlayer>(
  (_) => AudioPlayer()..setAsset(ModerniAliasSounds.wrong, preload: false),
  name: 'WrongPlayerProvider',
);
final countdownPlayerProvider = Provider<AudioPlayer>(
  (_) => AudioPlayer()..setAsset(ModerniAliasSounds.timer, preload: false),
  name: 'CountdownPlayerProvider',
);

final currentGameProvider = StateProvider.autoDispose<Game>(
  (_) => Game.none,
  name: 'CurrentGameProvider',
);
final countdownTimerFillColorProvider = StateProvider.autoDispose<Color>(
  (_) => ModerniAliasColors.blueColor,
  name: 'CountdownTimerFillColorProvider',
);
final playedWordsProvider = StateProvider.autoDispose<List<PlayedWord>>(
  (_) => [],
  name: 'PlayedWordsProvider',
);
final counter3SecondsProvider = StateProvider.autoDispose<int>(
  (_) => 0,
  name: 'Counter3SecondsProvider',
);
