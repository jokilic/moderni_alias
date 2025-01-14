import 'package:just_audio/just_audio.dart';

void playSound({required AudioPlayer audioPlayer}) => audioPlayer
  ..load()
  ..play();
