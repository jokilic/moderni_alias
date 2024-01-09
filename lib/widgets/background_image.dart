import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/durations.dart';
import '../constants/images.dart';

final backgroundImageProvider = StateNotifierProvider<BackgroundImageNotifier, String>(
  (_) => BackgroundImageNotifier(),
  name: 'BackgroundImageProvider',
);

class BackgroundImageNotifier extends StateNotifier<String> {
  BackgroundImageNotifier() : super(ModerniAliasImages.stars);

  ///
  /// VARIABLES
  ///

  late final random = Random();

  final backgrounds = [
    ModerniAliasImages.stars,
  ];

  ///
  /// METHODS
  ///

  /// Goes through `backgrounds` and changes to the next background
  void changeBackground() {
    final index = backgrounds.indexOf(state);
    final newIndex = (index + 1) % backgrounds.length;
    state = backgrounds[newIndex];
  }

  /// Goes through `backgrounds` and changes to a random background
  void randomWallpaper() {
    final currentIndex = backgrounds.indexOf(state);
    final randomIndex = random.nextInt(backgrounds.length);

    if (randomIndex == currentIndex) {
      changeBackground();
    } else {
      state = backgrounds[randomIndex];
    }
  }
}

class BackgroundImage extends ConsumerWidget {
  final Widget? child;

  const BackgroundImage({
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(backgroundImageProvider);

    return AnimatedSwitcher(
      duration: ModerniAliasDurations.animation,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      child: Container(
        key: ValueKey(image),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
