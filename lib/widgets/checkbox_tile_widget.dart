import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/durations.dart';
import '../constants/icons.dart';
import '../constants/text_styles.dart';
import 'animated_gesture_detector.dart';

class CheckboxTileWidget extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subtitle;
  final bool? isActive;

  const CheckboxTileWidget({
    required this.onPressed,
    required this.title,
    required this.subtitle,
    this.isActive,
  });

  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
    onTap: onPressed,
    child: ListTile(
      title: Text(
        title,
        style: ModerniAliasTextStyles.settingsTitle,
      ),
      subtitle: Text(
        subtitle,
        style: ModerniAliasTextStyles.settingsSubtitle,
      ),
      trailing: isActive != null
          ? AnimatedContainer(
              duration: ModerniAliasDurations.fastAnimation,
              curve: Curves.easeIn,
              margin: const EdgeInsets.only(left: 24),
              padding: const EdgeInsets.all(6),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ModerniAliasColors.white,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(16),
                color: isActive! ? ModerniAliasColors.white : Colors.transparent,
              ),
              child: AnimatedOpacity(
                opacity: isActive! ? 1 : 0,
                duration: ModerniAliasDurations.fastAnimation,
                curve: Curves.easeIn,
                child: Image.asset(
                  ModerniAliasIcons.correct,
                  color: ModerniAliasColors.darkBlue,
                ),
              ),
            )
          : Container(
              margin: const EdgeInsets.only(left: 24),
              height: 44,
              width: 44,
              child: Image.asset(
                ModerniAliasIcons.arrowSettings,
                color: ModerniAliasColors.white,
                height: 40,
                width: 40,
              ),
            ),
    ),
  );
}
