import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import 'animated_gesture_detector.dart';

class GameButton extends StatelessWidget {
  final String svgIconPath;
  final BorderRadius borderRadius;
  final Function() onTap;

  const GameButton({
    required this.svgIconPath,
    required this.borderRadius,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: AnimatedGestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(50),
            height: 150,
            decoration: BoxDecoration(
              color: ModerniAliasColors.whiteColor.withOpacity(0.05),
              borderRadius: borderRadius,
            ),
            child: SvgPicture.asset(
              svgIconPath,
              colorFilter: const ColorFilter.mode(
                ModerniAliasColors.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      );
}
