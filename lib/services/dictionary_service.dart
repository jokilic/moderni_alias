import 'package:get/get.dart';

class DictionaryService extends GetxService {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  final RxString _someString = ''.obs;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  String get someString => _someString.value;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set someString(String value) => _someString.value = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
  }
}
