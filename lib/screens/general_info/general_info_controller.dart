import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class GeneralInfoController extends GetxController {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final AudioPlayer audioPlayer;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer()..setAsset('assets/boom.wav', preload: false);
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  void playBoomBaby() => audioPlayer
    ..load()
    ..play();
}
