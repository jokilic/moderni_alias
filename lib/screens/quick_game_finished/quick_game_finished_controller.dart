import 'package:get/get.dart';

import '../../services/game_service.dart';
import '../home/home_screen.dart';

class QuickGameFinishedController extends GetxController {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  final _finalCorrectAnswers = 0.obs;
  final _finalWrongAnswers = 0.obs;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  int get finalCorrectAnswers => _finalCorrectAnswers.value;
  int get finalWrongAnswers => _finalWrongAnswers.value;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set finalCorrectAnswers(int value) => _finalCorrectAnswers.value = value;
  set finalWrongAnswers(int value) => _finalWrongAnswers.value = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
    initValues();
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  /// Values from [GameService] get assigned to relevant variables
  void initValues() {
    final gameService = Get.find<GameService>();

    finalCorrectAnswers = gameService.correctAnswers;
    finalWrongAnswers = gameService.wrongAnswers;
  }

  /// Goes back to the HomeScreen
  Future<bool> exitGame() async {
    await Get.offNamedUntil(
      HomeScreen.routeName,
      (route) => false,
    );
    return true;
  }
}
