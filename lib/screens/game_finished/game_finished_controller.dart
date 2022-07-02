import 'package:get/get.dart';

import '../../models/team.dart';
import '../../services/game_service.dart';
import '../../services/logger_service.dart';

class GameFinishedController extends GetxController {
  final logger = Get.find<LoggerService>();

  /// ------------------------
  /// REACTIVE VARIABLES
  /// ------------------------

  final _winningTeam = Team(name: '').obs;
  Team get winningTeam => _winningTeam.value;
  set winningTeam(Team value) => _winningTeam.value = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();

    // initWorkers();

    /// Winning team from [GameService] gets assigned to relevant variable
    winningTeam = Get.find<GameService>().currentlyPlayingTeam;
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Initializes workers which log when a variable has changed
  void initWorkers() => ever(_winningTeam, (value) => logger.v('winningTeam - $value'));
}
