import 'package:get/get.dart';

import '../screens/quick_game/quick_game_controller.dart';

class QuickGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuickGameController());
  }
}
