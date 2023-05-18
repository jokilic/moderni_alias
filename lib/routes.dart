import 'models/team/team.dart';
import 'screens/game_finished/game_finished_screen.dart';
import 'screens/general_info/general_info_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/how_to_play/how_to_play_screen.dart';
import 'screens/normal_game/normal_game_screen.dart';
import 'screens/normal_game_stats/normal_game_stats_screen.dart';
import 'screens/quick_game/quick_game_screen.dart';
import 'screens/quick_game_finished/quick_game_finished_screen.dart';
import 'screens/quick_game_stats/quick_game_stats_screen.dart';
import 'screens/start_game/start_game_screen.dart';
import 'screens/stats/stats_screen.dart';

final routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  GameFinishedScreen.routeName: (context) => GameFinishedScreen(winningTeam: Team(name: '')),
  GeneralInfoScreen.routeName: (context) => GeneralInfoScreen(),
  HowToPlayScreen.routeName: (context) => HowToPlayScreen(),
  NormalGameScreen.routeName: (context) => NormalGameScreen(),
  QuickGameScreen.routeName: (context) => QuickGameScreen(),
  QuickGameFinishedScreen.routeName: (context) => QuickGameFinishedScreen(),
  StartGameScreen.routeName: (context) => StartGameScreen(),
  StatsScreen.routeName: (context) => StatsScreen(),
  NormalGameStatsScreen.routeName: (context) => NormalGameStatsScreen(),
  QuickGameStatsScreen.routeName: (context) => QuickGameStatsScreen(),
};
