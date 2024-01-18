import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class InfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => goToGeneralInfoScreen(context),
        end: 0.8,
        child: IconButton(
          onPressed: null,
          icon: Image.asset(
            ModerniAliasIcons.infoImage,
            color: ModerniAliasColors.white,
            height: 32,
            width: 32,
          ),
          iconSize: 32,
        ),
      );
}
