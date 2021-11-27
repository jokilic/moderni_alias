import 'package:get/get.dart';

class MainGameController extends GetxController {
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
