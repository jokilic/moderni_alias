import 'package:flutter/material.dart';

class HowToPlayText extends StatelessWidget {
  final Widget textChild;

  HowToPlayText(this.textChild);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 24.0,
      ),
      child: textChild,
    );
  }
}
