import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../constants/durations.dart';
import '../services/background_image_service.dart';

class BackgroundImage extends WatchingWidget {
  final Widget? child;

  const BackgroundImage({this.child});

  @override
  Widget build(BuildContext context) {
    final backgroundImage = watchIt<BackgroundImageService>().value;

    return AnimatedSwitcher(
      duration: ModerniAliasDurations.animation,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      child: Container(
        key: ValueKey(backgroundImage),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
