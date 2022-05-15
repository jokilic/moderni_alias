import 'package:get/get.dart';

import 'stats_controller.dart';

class StatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(StatsController.new);
  }
}
