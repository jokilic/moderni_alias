import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

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
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(50),
            height: 150,
            decoration: BoxDecoration(
              color: whiteColor.withOpacity(0.05),
              borderRadius: borderRadius,
            ),
            child: SvgPicture.asset(
              svgIconPath,
              color: whiteColor,
            ),
          ),
        ),
      );
}
