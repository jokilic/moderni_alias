import 'package:get/get.dart';

import '../../models/team.dart';
import '../../services/game_service.dart';

class GameFinishedController extends GetxController {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  final _winningTeam = Team(name: '').obs;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  Team get winningTeam => _winningTeam.value;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set winningTeam(Team value) => _winningTeam.value = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();

    /// Winning team from [GameService] gets assigned to relevant variable
    winningTeam = Get.find<GameService>().currentlyPlayingTeam;
  }
}
