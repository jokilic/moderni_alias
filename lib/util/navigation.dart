import 'package:flutter/material.dart';

import '../constants/durations.dart';

Future<T?> pushScreen<T>(
  Widget screen, {
  required BuildContext context,
  bool popEverything = false,
  bool isCircularTransition = false,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) =>
    popEverything
        ? Navigator.of(context).pushAndRemoveUntil(
            isCircularTransition
                ? circularPageTransition(
                    screen,
                    transitionDuration: transitionDuration,
                    reverseTransitionDuration: reverseTransitionDuration,
                  )
                : fadePageTransition(
                    screen,
                    transitionDuration: transitionDuration,
                    reverseTransitionDuration: reverseTransitionDuration,
                  ),
            (route) => false,
          )
        : Navigator.of(context).push<T>(
            isCircularTransition
                ? circularPageTransition(
                    screen,
                    transitionDuration: transitionDuration,
                    reverseTransitionDuration: reverseTransitionDuration,
                  )
                : fadePageTransition(
                    screen,
                    transitionDuration: transitionDuration,
                    reverseTransitionDuration: reverseTransitionDuration,
                  ),
          );

Route<T> fadePageTransition<T>(
  Widget screen, {
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) =>
    PageRouteBuilder<T>(
      transitionDuration: transitionDuration ?? ModerniAliasDurations.fastAnimation,
      reverseTransitionDuration: reverseTransitionDuration ?? ModerniAliasDurations.fastAnimation,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

Route<T> circularPageTransition<T>(
  Widget screen, {
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) =>
    PageRouteBuilder<T>(
      transitionDuration: transitionDuration ?? ModerniAliasDurations.fastAnimation,
      reverseTransitionDuration: reverseTransitionDuration ?? ModerniAliasDurations.fastAnimation,
      opaque: false,
      pageBuilder: (_, __, ___) => screen,
      transitionsBuilder: (context, animation, _, child) {
        final screenSize = MediaQuery.sizeOf(context);

        final center = Offset(
          screenSize.width / 2,
          kToolbarHeight + 40,
        );

        const beginRadius = 0.0;
        final endRadius = screenSize.height * 1.2;

        final tween = Tween<double>(begin: beginRadius, end: endRadius);
        final radiusTweenAnimation = animation.drive(tween);

        return ClipPath(
          clipper: CircularTransitionClipper(
            radius: radiusTweenAnimation.value,
            center: center,
          ),
          child: child,
        );
      },
    );

class CircularTransitionClipper extends CustomClipper<Path> {
  final double radius;
  final Offset center;

  CircularTransitionClipper({
    required this.radius,
    required this.center,
  });

  @override
  Path getClip(Size size) => Path()
    ..addOval(
      Rect.fromCircle(
        radius: radius,
        center: center,
      ),
    );

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
