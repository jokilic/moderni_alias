import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/strings.dart';

class Confetti extends StatefulWidget {
  final Duration waitDuration;

  const Confetti({
    this.waitDuration = Duration.zero,
  });

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: ModerniAliasDurations.slowAnimation,
      vsync: this,
    );

    Future.delayed(widget.waitDuration, animationController.repeat);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Lottie.asset(
        ModerniAliasAnimations.confetti,
        controller: animationController,
        onLoaded: (composition) => animationController..duration = composition.duration,
      );
}
