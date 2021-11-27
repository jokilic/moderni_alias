import 'package:flutter/material.dart';

class StandardText extends StatelessWidget {
  final Widget textChild;

  const StandardText(this.textChild);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: textChild,
      );
}
