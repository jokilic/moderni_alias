import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'constants/colors.dart';
import 'constants/enums.dart';
import 'constants/strings.dart';
import 'models/played_word/played_word.dart';

final randomProvider = Provider<Random>((_) => Random());
final correctPlayerProvider = Provider<AudioPlayer>(
  (_) => AudioPlayer()..setAsset(ModerniAliasSounds.correct, preload: false),
);
final wrongPlayerProvider = Provider<AudioPlayer>(
  (_) => AudioPlayer()..setAsset(ModerniAliasSounds.wrong, preload: false),
);
final countdownPlayerProvider = Provider<AudioPlayer>(
  (_) => AudioPlayer()..setAsset(ModerniAliasSounds.timer, preload: false),
);

final currentGameProvider = StateProvider<Game>((_) => Game.none);
final countdownTimerFillColorProvider = StateProvider<Color>((_) => ModerniAliasColors.blueColor);
final playedWordsProvider = StateProvider<List<PlayedWord>>((_) => []);
final counter3SecondsProvider = StateProvider<int>((_) => 0);