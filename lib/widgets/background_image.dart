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
  }) : super(hive.getBackgroundFromBox() ?? ModerniAliasImages.starsStandard);

  ///
  /// VARIABLES
  ///

  late final random = Random();

  final backgrounds = [
    ModerniAliasImages.starsStandard,
    ModerniAliasImages.starsDark,
    ModerniAliasImages.starsLight,
    ModerniAliasImages.blurredPurple,
    ModerniAliasImages.blurredBlue,
    ModerniAliasImages.blurredGreen,
    ModerniAliasImages.blurredYellow,
    ModerniAliasImages.blurredRed,
    ModerniAliasImages.blurredGrey,
  ];

  ///
  /// METHODS
  ///

  /// Goes through `backgrounds` and changes to the next background
  void cycleBackgrounds() {
    final index = backgrounds.indexOf(state);
    final newIndex = (index + 1) % backgrounds.length;
    changeBackground(backgrounds[newIndex], isTemporary: false);
  }

  /// Goes through `backgrounds` and changes to a random background
  void randomWallpaper() {
    final currentIndex = backgrounds.indexOf(state);
    final randomIndex = random.nextInt(backgrounds.length);

    if (randomIndex == currentIndex) {
      cycleBackgrounds();
    } else {
      changeBackground(backgrounds[randomIndex], isTemporary: true);
    }
  }

  /// Updates background to the passed one
  Future<void> changeBackground(String newBackground, {required bool isTemporary}) async {
    state = newBackground;

    /// Store new background in [Hive]
    if (!isTemporary) {
      await hive.addBackgroundToBox(background: newBackground);
    }
  }

  /// Revert background to stored one
  Future<void> revertBackground() async => changeBackground(
        hive.getBackgroundFromBox() ?? ModerniAliasImages.starsStandard,
        isTemporary: false,
      );
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
