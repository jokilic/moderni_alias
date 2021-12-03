import 'package:flutter/material.dart';

import '../constants/strings.dart';

class BackgroundImage extends StatelessWidget {
  final Widget? child;

  const BackgroundImage({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ModerniAliasImages.backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      );
}
