import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class GameButton extends StatelessWidget {
  final String svgIconPath;

  final BorderRadius borderRadius;
  final Function onTap;

  GameButton({
    this.svgIconPath,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(54.0),
          child: SvgPicture.asset(
            svgIconPath,
            color: buttonColor,
          ),
          height: 185.0,
          decoration: BoxDecoration(
            color: buttonBackgroundColor,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}
