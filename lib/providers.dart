import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import 'constants/strings.dart';

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
