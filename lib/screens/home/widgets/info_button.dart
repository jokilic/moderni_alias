import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../general_info/general_info_screen.dart';

class InfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => Get.toNamed(
          GeneralInfoScreen.routeName,
        ),
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
