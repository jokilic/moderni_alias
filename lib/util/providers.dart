import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/sounds.dart';
import '../models/played_word/played_word.dart';
import '../models/team/team.dart';

final randomProvider = Provider<Random>(
  (_) => Random(),
  name: 'RandomProvider',
);

///
/// AUDIO
///

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

final timeGameEndPlayerProvider = Provider<AudioPlayer>(
  (_) => AudioPlayer()..setAsset(ModerniAliasSounds.timeGameEnd, preload: false),
  name: 'TimeGameEndPlayerProvider',
);

///
/// TEAMS
///

final currentlyPlayingTeamProvider = StateProvider.autoDispose<Team>(
  (ref) => ref.read(teamsProvider).first,
  name: 'CurrentlyPlayingTeamProvider',
);

final teamsProvider = StateProvider.autoDispose<List<Team>>(
  (_) => [for (var i = 0; i < 2; i++) Team(name: '', textEditingController: TextEditingController())],
  name: 'TeamsProvider',
);

final teamsLengthProvider = StateProvider.autoDispose<int>(
  (ref) => ref.watch(teamsProvider).length,
  name: 'TeamsLengthProvider',
);

final tieBreakTeamsProvider = StateProvider<List<Team>?>(
  (_) => null,
  name: 'TieBreakTeamsProvider',
);

///
/// GAME
///

final currentGameProvider = StateProvider.autoDispose<Game>(
  (_) => Game.tapToStart,
  name: 'CurrentGameProvider',
);

final counter3SecondsProvider = StateProvider.autoDispose<int>(
  (_) => 0,
  name: 'Counter3SecondsProvider',
);

///
/// TIMER
///

final countdownTimerFillColorProvider = StateProvider.autoDispose<Color>(
  (_) => ModerniAliasColors.blueColor,
  name: 'CountdownTimerFillColorProvider',
);

final timeGameTimerProvider = StateProvider<Duration>(
  (_) => Duration.zero,
  name: 'TimeGameTimerProvider',
);

///
/// WORDS
///

final playedWordsProvider = StateProvider.autoDispose<List<PlayedWord>>(
  (_) => [],
  name: 'PlayedWordsProvider',
);

///
/// SETUP
///

final pointsToWinProvider = StateProvider.autoDispose<int>(
  (_) => 50,
  name: 'PointsToWinProvider',
);

final lengthOfRoundProvider = StateProvider.autoDispose<int>(
  (_) => 60,
  name: 'LengthOfRoundProvider',
);

final wordsToWinProvider = StateProvider.autoDispose<int>(
  (_) => 10,
  name: 'WordsToWinProvider',
);

final validationMessageProvider = StateProvider.autoDispose<String?>(
  (_) => null,
  name: 'ValidationMessageProvider',
);
