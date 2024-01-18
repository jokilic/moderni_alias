import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/durations.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';

class SettingsCheckboxTile extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String subtitle;
  final bool? isActive;

  const SettingsCheckboxTile({
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
                  margin: const EdgeInsets.only(left: 24),
                  padding: const EdgeInsets.all(6),
                  duration: ModerniAliasDurations.fastAnimation,
                  curve: Curves.easeIn,
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
                    child: SvgPicture.asset(
                      ModerniAliasIcons.correctImage,
                      colorFilter: const ColorFilter.mode(
                        ModerniAliasColors.darkBlue,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(left: 24),
                  height: 44,
                  width: 44,
                  child: Image.asset(
                    ModerniAliasIcons.arrowSettingsImage,
                    color: ModerniAliasColors.white,
                    height: 40,
                    width: 40,
                  ),
                ),
        ),
      );
}
