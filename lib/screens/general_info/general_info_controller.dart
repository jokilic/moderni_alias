import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class GeneralInfoController extends GetxController {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final AudioCache _audioCache;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  AudioCache get audioCache => _audioCache;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set audioCache(AudioCache value) => _audioCache = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
    audioCache = AudioCache();
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  void playBoomBaby() => audioCache.play('boom.wav');
}
