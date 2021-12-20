import 'package:get/get.dart';

import '../screens/general_info/general_info_controller.dart';

class GeneralInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(GeneralInfoController.new);
  }
}
