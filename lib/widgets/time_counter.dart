import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../util/providers.dart';

class TimeCounter extends StatefulWidget {
  final int roundLength;

  const TimeCounter({
    required this.roundLength,
  });

  @override
  State<StatefulWidget> createState() => TimeCounterState();
}

class TimeCounterState extends State<TimeCounter> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.roundLength),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Logic to control animation depending on the game state
    ref.listen(currentGameProvider, (_, state) {
      switch (state) {
        /// Game is running, start animation
        case GameState.playing:
          controller.forward();
          break;

        /// Game is not running, stop animation
        case GameState.idle:
        case GameState.starting:
        case GameState.finished:
          controller.reset();
          break;
      }
    });

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => LinearProgressIndicator(
        value: controller.value,
        borderRadius: BorderRadius.circular(100),
        backgroundColor: Colors.transparent,
        color: ModerniAliasColors.white.withValues(alpha: 0.7),
      ),
    );
  }
}
