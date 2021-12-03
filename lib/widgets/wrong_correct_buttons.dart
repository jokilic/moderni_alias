import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './game_button.dart';
import '../constants/strings.dart';

class WrongCorrectButtons extends StatelessWidget {
  final Function() wrongChosen;
  final Function() correctChosen;

  const WrongCorrectButtons({
    required this.wrongChosen,
    required this.correctChosen,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GameButton(
            svgIconPath: ModerniAliasImages.wrongImage,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
            ),
            onTap: wrongChosen,
          ),
          GameButton(
            svgIconPath: ModerniAliasImages.correctImage,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.r),
            ),
            onTap: correctChosen,
          ),
        ],
      );
}
