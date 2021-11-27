import 'package:get/get.dart';

import '../screens/start_game/start_game_controller.dart';

class StartGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartGameController());
  }
}
