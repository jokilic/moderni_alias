import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.all(50.r),
            height: 150.h,
            decoration: BoxDecoration(
              color: ModerniAliasColors.whiteColor.withOpacity(0.05),
              borderRadius: borderRadius,
            ),
            child: SvgPicture.asset(
              svgIconPath,
              color: ModerniAliasColors.whiteColor,
            ),
          ),
        ),
      );
}
