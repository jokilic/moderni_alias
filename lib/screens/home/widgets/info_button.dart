import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class InfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
    onTap: () => openGeneralInfo(context),
    end: 0.8,
    child: IconButton(
      onPressed: null,
      icon: Image.asset(
        ModerniAliasIcons.info,
        color: ModerniAliasColors.white,
        height: 30,
        width: 30,
      ),
      iconSize: 30,
    ),
  );
}
