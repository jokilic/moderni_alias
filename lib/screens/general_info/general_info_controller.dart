import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../constants/strings.dart';

final generalInfoProvider = Provider<GeneralInfoController>((_) => GeneralInfoController());

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
