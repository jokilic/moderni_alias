import 'package:get/get.dart';

import '../services/dictionary_service.dart';
import '../services/game_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put(DictionaryService())
      ..put(GameService());
  }
}
