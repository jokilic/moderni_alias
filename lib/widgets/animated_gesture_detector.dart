import 'package:flutter/material.dart';

import '../constants/durations.dart';

class AnimatedGestureDetector extends StatefulWidget {
  final Function()? onTap;
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final Curve curve;

  const AnimatedGestureDetector({
    required this.child,
    this.onTap,
    this.duration = ModerniAliasDurations.veryFastAnimation,
    this.begin = 1,
    this.end = 0.9,
    this.curve = Curves.easeIn,
  });

  @override
  State<AnimatedGestureDetector> createState() => _AnimatedGestureDetectorState();
}

class _AnimatedGestureDetectorState extends State<AnimatedGestureDetector> with SingleTickerProviderStateMixin {
  late Animation<double> scaleAnimation;
  late AnimationController animationController;

  final tolerance = 25.0;
  var shouldTrigger = true;
  Offset? downPosition;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    scaleAnimation = Tween<double>(
      begin: widget.begin,
      end: widget.end,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.curve,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Listener(
        onPointerDown: (details) {
          animationController.forward();

          shouldTrigger = true;
          downPosition = details.localPosition;
        },
        onPointerUp: (details) {
          animationController.reverse();

          if (shouldTrigger) {
            final upPosition = details.localPosition;
            final distance = (upPosition - downPosition!).distance;

            if (distance <= tolerance && widget.onTap != null) {
              widget.onTap!();
            }
          }
        },
        onPointerMove: (details) {
          final movePosition = details.localPosition;
          final distance = (movePosition - downPosition!).distance;

          shouldTrigger = distance <= tolerance;
        },
        child: ScaleTransition(
          scale: scaleAnimation,
          child: widget.child,
        ),
      );
}
