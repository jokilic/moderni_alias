import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';

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
        padding: EdgeInsets.only(
          top: 24.h,
          bottom: 16.h,
        ),
        child: InkWell(
          onTap: onTap,
          child: AnimatedColumn(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: backgroundColor,
                    height: 75.h,
                    width: 80.w,
                  ),
                  SvgPicture.asset(
                    flagImage,
                    width: 90.w,
                    color: color,
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
      );
}

Widget createFlagButton({
  required String countryName,
  required Flag selectedCountry,
  required String flagImage,
  required Function() updateValue,
  required bool isActive,
}) =>
    FlagButton(
      countryName: countryName,
      backgroundColor: isActive ? ModerniAliasColors.whiteColor : Colors.transparent,
      color: isActive ? ModerniAliasColors.darkblueColor : ModerniAliasColors.whiteColor,
      flagImage: flagImage,
      onTap: updateValue,
    );
