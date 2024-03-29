import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/durations.dart';
import '../../../constants/icons.dart';
import '../../../widgets/animated_gesture_detector.dart';

class SettingsBackgrounds extends StatelessWidget {
  final List<String> backgrounds;
  final String activeBackground;
  final Function(String pressedBackground) onPressed;

  const SettingsBackgrounds({
    required this.backgrounds,
    required this.activeBackground,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Wrap(
          spacing: 32,
          runSpacing: 32,
          children: backgrounds
              .map(
                (background) => AnimatedGestureDetector(
                  onTap: () => onPressed(background),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.white,
                            ),
                            height: 96,
                            width: 96,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              background,
                              height: 88,
                              width: 88,
                              fit: BoxFit.cover,
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: activeBackground == background ? 1 : 0,
                            duration: ModerniAliasDurations.fastAnimation,
                            curve: Curves.easeIn,
                            child: SvgPicture.asset(
                              ModerniAliasIcons.correctImage,
                              colorFilter: const ColorFilter.mode(
                                ModerniAliasColors.white,
                                BlendMode.srcIn,
                              ),
                              height: 36,
                              width: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
