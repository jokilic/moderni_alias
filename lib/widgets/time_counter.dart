import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../util/providers.dart';

class TimeCounter extends ConsumerStatefulWidget {
  final int roundLength;

  const TimeCounter({
    required this.roundLength,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TimeCounterState();
}

class TimeCounterState extends ConsumerState<TimeCounter> with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    /// Logic to control animation depending on the game state
    ref.listen(currentGameProvider, (_, state) {
      switch (state) {
        /// Game is running, start animation
        case Game.normal:
        case Game.quick:
        case Game.time:
          controller.forward();
          break;

        /// Game is not running, stop animation
        case Game.tapToStart:
        case Game.starting:
        case Game.end:
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
        color: ModerniAliasColors.white.withOpacity(0.7),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
