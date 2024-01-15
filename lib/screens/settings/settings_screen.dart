import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import 'widgets/settings_backgrounds_widget.dart';

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeBackground = ref.watch(backgroundImageProvider);
    final backgrounds = ref.watch(backgroundImageProvider.notifier).backgrounds;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GameTitle('Background'),
                    const SizedBox(height: 20),
                    SettingsBackgroundsWidget(
                      backgrounds: backgrounds,
                      activeBackground: activeBackground,
                      onPressed: (newBackground) => ref.read(backgroundImageProvider.notifier).changeBackground(
                            newBackground,
                            isTemporary: false,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
