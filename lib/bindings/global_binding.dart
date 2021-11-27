import 'package:get/get.dart';

import '../services/dictionary_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DictionaryService());
  }
}
