import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/images.dart';
import 'hive_service.dart';
import 'logger_service.dart';

class BackgroundImageService extends ValueNotifier<String> {
  final LoggerService logger;
  final HiveService hive;

  BackgroundImageService({
    required this.logger,
    required this.hive,
  }) : super(hive.getSettingsFromBox().background);

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
    final index = backgrounds.indexOf(value);
    final newIndex = (index + 1) % backgrounds.length;
    changeBackground(backgrounds[newIndex], isTemporary: false);
  }

  /// Goes through `backgrounds` and changes to a random background
  void randomWallpaper() {
    final currentIndex = backgrounds.indexOf(value);
    final randomIndex = random.nextInt(backgrounds.length);

    if (randomIndex == currentIndex) {
      cycleBackgrounds();
    } else {
      changeBackground(backgrounds[randomIndex], isTemporary: true);
    }
  }

  /// Updates background to the passed one
  Future<void> changeBackground(String newBackground, {required bool isTemporary}) async {
    value = newBackground;

    /// Store new background in [Hive]
    if (!isTemporary) {
      final oldSettings = hive.getSettingsFromBox();
      await hive.addSettingsToBox(
        oldSettings.copyWith(
          background: newBackground,
        ),
      );
    }
  }

  /// Revert background to stored one
  Future<void> revertBackground() async => changeBackground(
        hive.getSettingsFromBox().background,
        isTemporary: false,
      );
}
