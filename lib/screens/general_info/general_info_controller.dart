import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/sounds.dart';

final generalInfoProvider = Provider.autoDispose<GeneralInfoController>(
  (_) => GeneralInfoController(),
  name: 'GeneralInfoProvider',
);

class GeneralInfoController {
  ///
  /// CONSTRUCTOR
  ///

  GeneralInfoController() {
    init();
  }

  ///
  /// VARIABLES
  ///

  late final AudioPlayer audioPlayer;

  ///
  /// INIT
  ///

  void init() {
    audioPlayer = AudioPlayer()..setAsset(ModerniAliasSounds.boom, preload: false);
  }

  ///
  /// METHODS
  ///

  void playBoomBaby() => audioPlayer
    ..load()
    ..play();
}
