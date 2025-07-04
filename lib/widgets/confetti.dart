import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../constants/animations.dart';
import '../constants/durations.dart';

class Confetti extends StatefulWidget {
  final Duration waitDuration;

  const Confetti({
    this.waitDuration = Duration.zero,
  });

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  RiveAnimationController? controller;

  @override
  void initState() {
    super.initState();

    /// Initialize [RiveAnimationController]
    Future.delayed(
      widget.waitDuration,
      () {
        if (mounted) {
          setState(
            () => controller = OneShotAnimation(
              'Animation 1',
              onStop: () => Future.delayed(
                ModerniAliasDurations.verySlowAnimation,
                () => controller?.isActive = true,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => controller != null
      ? RiveAnimation.asset(
          fit: BoxFit.cover,
          ModerniAliasAnimations.confetti,
          controllers: [controller!],
          onInit: (_) => setState(() {}),
        )
      : const SizedBox.shrink();
}
