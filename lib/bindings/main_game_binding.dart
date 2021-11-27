import 'package:get/get.dart';

import '../screens/main_game/main_game_controller.dart';

class MainGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainGameController());
  }
}
