import 'package:flutter/material.dart';

import '../strings.dart';

class BackgroundImage extends StatelessWidget {
  final Widget? child;

  BackgroundImage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            backgroundImage,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
