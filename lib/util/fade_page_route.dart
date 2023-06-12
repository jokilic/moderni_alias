import 'package:flutter/cupertino.dart';

class FadePageRoute<T> extends CupertinoPageRoute<T> {
  FadePageRoute({required super.builder});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final widget = super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );

    if (widget is CupertinoPageTransition) {
      return FadeTransition(
        opacity: animation,
        child: widget.child,
      );
    } else {
      return widget;
    }
  }
}
