import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../routes.dart';
import '../../../widgets/animated_gesture_detector.dart';

class InfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => goToGeneralInfoScreen(context),
        end: 0.8,
        child: const IconButton(
          onPressed: null,
          icon: Icon(
            Icons.info_outline_rounded,
            color: ModerniAliasColors.whiteColor,
          ),
          iconSize: 36,
        ),
      );
}
