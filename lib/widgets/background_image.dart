import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/durations.dart';
import '../constants/images.dart';
import '../services/hive_service.dart';

final backgroundImageProvider = StateNotifierProvider<BackgroundImageNotifier, String>(
  (ref) => BackgroundImageNotifier(
    hive: ref.watch(hiveProvider),
  ),
  name: 'BackgroundImageProvider',
);

class BackgroundImageNotifier extends StateNotifier<String> {
  final HiveService hive;

  BackgroundImageNotifier({
    required this.hive,
  }) : super(hive.getBackgroundFromBox() ?? ModerniAliasImages.stars1);

  ///
  /// VARIABLES
  ///

  late final random = Random();

  final backgrounds = [
    ModerniAliasImages.stars1,
    ModerniAliasImages.stars2,
    ModerniAliasImages.stars3,
    ModerniAliasImages.blurred1,
    ModerniAliasImages.blurred2,
    ModerniAliasImages.blurred3,
    ModerniAliasImages.blurred4,
    ModerniAliasImages.blurred5,
    ModerniAliasImages.blurred6,
    ModerniAliasImages.blurred7,
    ModerniAliasImages.blurred8,
    ModerniAliasImages.blurred9,
    ModerniAliasImages.blurred10,
    ModerniAliasImages.blurred11,
    ModerniAliasImages.blurred12,
    ModerniAliasImages.blurred13,
    ModerniAliasImages.blurred14,
    ModerniAliasImages.blurred15,
    ModerniAliasImages.blurred16,
    ModerniAliasImages.blurred17,
    ModerniAliasImages.blurred18,
    ModerniAliasImages.blurred19,
  ];

  ///
  /// METHODS
  ///

  /// Goes through `backgrounds` and changes to the next background
  void cycleBackgrounds() {
    final index = backgrounds.indexOf(state);
    final newIndex = (index + 1) % backgrounds.length;
    changeBackground(backgrounds[newIndex]);
  }

  /// Goes through `backgrounds` and changes to a random background
  void randomWallpaper() {
    final currentIndex = backgrounds.indexOf(state);
    final randomIndex = random.nextInt(backgrounds.length);

    if (randomIndex == currentIndex) {
      cycleBackgrounds();
    } else {
      changeBackground(backgrounds[randomIndex]);
    }
  }

  /// Updates background to the passed one
  Future<void> changeBackground(String newBackground) async {
    state = newBackground;
    await hive.addBackgroundToBox(background: newBackground);
  }
}

class BackgroundImage extends ConsumerWidget {
  final Widget? child;

  const BackgroundImage({this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(backgroundImageProvider);

    return AnimatedSwitcher(
      duration: ModerniAliasDurations.animation,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      child: Container(
        key: ValueKey(image),
        height: double.infinity,
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
