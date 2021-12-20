import 'package:get/get.dart';

import 'bindings/game_finished_binding.dart';
import 'bindings/general_info_binding.dart';
import 'screens/game_finished/game_finished_screen.dart';
import 'screens/general_info/general_info_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/how_to_play/how_to_play_screen.dart';
import 'screens/main_game/main_game_screen.dart';
import 'screens/quick_game/quick_game_screen.dart';
import 'screens/quick_game_finished/quick_game_finished_screen.dart';
import 'screens/start_game/start_game_screen.dart';

final routes = [
  GetPage(
    name: HomeScreen.routeName,
    page: HomeScreen.new,
  ),
  GetPage(
    name: GameFinishedScreen.routeName,
    page: GameFinishedScreen.new,
    binding: GameFinishedBinding(),
  ),
  GetPage(
    name: GeneralInfoScreen.routeName,
    page: GeneralInfoScreen.new,
    binding: GeneralInfoBinding(),
  ),
  GetPage(
    name: HowToPlayScreen.routeName,
    page: HowToPlayScreen.new,
  ),
  GetPage(
    name: MainGameScreen.routeName,
    page: MainGameScreen.new,
  ),
  GetPage(
    name: QuickGameScreen.routeName,
    page: QuickGameScreen.new,
  ),
  GetPage(
    name: QuickGameFinishedScreen.routeName,
    page: QuickGameFinishedScreen.new,
  ),
  GetPage(
    name: StartGameScreen.routeName,
    page: StartGameScreen.new,
  ),
];
