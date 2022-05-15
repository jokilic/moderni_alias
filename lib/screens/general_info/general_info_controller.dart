import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class GeneralInfoController extends GetxController {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final AudioPlayer _audioPlayer;
  AudioPlayer get audioPlayer => _audioPlayer;
  set audioPlayer(AudioPlayer value) => _audioPlayer = value;

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
