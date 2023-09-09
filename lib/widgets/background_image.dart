import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/durations.dart';
import '../constants/images.dart';

final backgroundImageProvider = StateProvider<String>(
  (_) => ModerniAliasImages.backgroundImage,
  name: 'BackgroundImageProvider',
);

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
