import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class GameButton extends StatelessWidget {
  final String? svgIconPath;

  final BorderRadius? borderRadius;
  final Function? onTap;

  GameButton({
    this.svgIconPath,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          padding: EdgeInsets.all(50.0),
          child: SvgPicture.asset(
            svgIconPath!,
            color: whiteColor,
          ),
          height: 150.0,
          decoration: BoxDecoration(
            color: whiteColor.withOpacity(0.05),
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
