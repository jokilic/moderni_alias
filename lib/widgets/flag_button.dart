import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../screens/start_game/start_game_screen.dart';

enum Flags {
  croatia,
  unitedKingdom,
}

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
        child: InkWell(
          onTap: onTap,
          child: Column(
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
                    color: color,
                  ),
                ],
              ),
              Text(
                countryName,
                style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}

Widget createFlagButton({
  required String countryName,
  required Flags selectedCountry,
  required String flagImage,
  required Function() updateValue,
}) =>
    FlagButton(
      countryName: countryName,
      backgroundColor: chosenDictionary == selectedCountry ? whiteColor : Colors.transparent,
      color: chosenDictionary == selectedCountry ? darkBlueColor : whiteColor,
      flagImage: flagImage,
      onTap: updateValue,
    );
