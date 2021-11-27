import 'package:get/get.dart';

import '../screens/quick_game_finished/quick_game_finished_controller.dart';

class QuickGameFinishedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuickGameFinishedController());
  }
}
