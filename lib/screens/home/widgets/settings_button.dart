import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => goToSettingsScreen(context),
        end: 0.8,
        child: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.settings_rounded,
            color: ModerniAliasColors.white,
          ),
          iconSize: 36,
        ),
      );
}
