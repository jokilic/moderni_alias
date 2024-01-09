import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/durations.dart';
import '../constants/images.dart';

final backgroundImageProvider = StateNotifierProvider<BackgroundImageNotifier, String>(
  (_) => BackgroundImageNotifier(),
  name: 'BackgroundImageProvider',
);

class BackgroundImageNotifier extends StateNotifier<String> {
  BackgroundImageNotifier() : super(ModerniAliasImages.backgroundImage);

  ///
  /// VARIABLES
  ///

  final backgrounds = [
    ModerniAliasImages.backgroundImage,
  ];

  ///
  /// METHODS
  ///

  /// Goes through `backgrounds` and changes active background
  void changeBackground() {
    final index = backgrounds.indexOf(state);
    final newIndex = (index + 1) % backgrounds.length;
    state = backgrounds[newIndex];
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
