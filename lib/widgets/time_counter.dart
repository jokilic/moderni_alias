import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../screens/normal_game/normal_game_controller.dart';
import '../screens/quick_game/quick_game_controller.dart';

class TimeCounter extends StatefulWidget {
  final int lengthOfRound;
  final NormalGameController? normalGameController;
  final QuickGameController? quickGameController;

  const TimeCounter({
    required this.lengthOfRound,
    this.normalGameController,
    this.quickGameController,
  });

  @override
  State<StatefulWidget> createState() => TimeCounterState();
}

class TimeCounterState extends State<TimeCounter> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.lengthOfRound),
    );

    widget.normalGameController?.addListener(animationListener);
    widget.quickGameController?.addListener(animationListener);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void animationListener() {
    final gameState = widget.normalGameController?.value.gameState ?? widget.quickGameController?.value.gameState;

    if (gameState != null) {
      switch (gameState) {
        /// Game is running, start animation
        case GameState.playing:
          animationController.forward();

        /// Game is not running, stop animation
        default:
          animationController.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animationController,
        builder: (_, __) => LinearProgressIndicator(
          value: animationController.value,
          borderRadius: BorderRadius.circular(100),
          backgroundColor: Colors.transparent,
          color: ModerniAliasColors.white.withValues(alpha: 0.7),
        ),
      );
}
