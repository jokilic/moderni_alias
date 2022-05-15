import 'package:get/get.dart';

import 'game_finished_controller.dart';

class GameFinishedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GameFinishedController.new);
  }
}
