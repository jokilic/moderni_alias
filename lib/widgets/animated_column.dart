import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../constants/durations.dart';

class AnimatedColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool fastAnimations;

  const AnimatedColumn({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.fastAnimations = false,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: AnimationConfiguration.toStaggeredList(
          duration: fastAnimations ? ModerniAliasDurations.animation : ModerniAliasDurations.slowAnimation,
          childAnimationBuilder: (widget) => SlideAnimation(
            curve: Curves.easeIn,
            duration: fastAnimations ? ModerniAliasDurations.fastAnimation : ModerniAliasDurations.animation,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: children,
        ),
      );
}
