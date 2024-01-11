import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';
import 'animated_gesture_detector.dart';

class FlagButton extends StatelessWidget {
  final String countryName;
  final String flagImage;
  final Color color;
  final Color backgroundColor;
  final Function() onTap;

  const FlagButton({
    required this.countryName,
    required this.flagImage,
    required this.color,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 24,
          bottom: 16,
        ),
        child: AnimatedGestureDetector(
          onTap: onTap,
          child: InkWell(
            onTap: () {},
            child: AnimatedColumn(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: backgroundColor,
                      height: 75,
                      width: 80,
                    ),
                    SvgPicture.asset(
                      flagImage,
                      width: 90,
                      colorFilter: ColorFilter.mode(
                        color,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                Text(
                  countryName,
                  style: ModerniAliasTextStyles.flagName,
                ),
              ],
            ),
          ),
        ),
      );
}

Widget createFlagButton({
  required String countryName,
  required Flag selectedCountry,
  required String flagImage,
  required Function() onTap,
  required bool isActive,
}) =>
    FlagButton(
      countryName: countryName,
      backgroundColor: isActive ? ModerniAliasColors.white : Colors.transparent,
      color: isActive ? ModerniAliasColors.darkBlue : ModerniAliasColors.white,
      flagImage: flagImage,
      onTap: onTap,
    );
