import 'package:flutter/material.dart';

class StandardText extends StatelessWidget {
  final Widget textChild;

  StandardText(this.textChild);

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
