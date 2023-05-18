import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static const int mobileBreakpoint = 850;
  static const int desktopBreakpoint = 1100;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= desktopBreakpoint) {
            return desktop ?? tablet ?? mobile;
          } else if (constraints.maxWidth >= mobileBreakpoint) {
            return tablet ?? mobile;
          } else {
            return mobile;
          }
        },
      );
}
