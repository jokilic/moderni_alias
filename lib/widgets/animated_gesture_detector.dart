import 'package:flutter/material.dart';

import '../constants/strings.dart';

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
  var shouldTrigger = true;

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
        onPointerMove: (_) => shouldTrigger = false,
        onPointerDown: (_) {
          shouldTrigger = true;
          animationController.forward();
        },
        onPointerUp: (_) {
          animationController.reverse();
          if (widget.onTap != null && shouldTrigger) {
            widget.onTap!();
          }
        },
        child: ScaleTransition(
          scale: scaleAnimation,
          child: widget.child,
        ),
      );
}
