import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: IconButton(
          onPressed: null,
          icon: const Icon(
            Icons.info_outline,
            color: ModerniAliasColors.whiteColor,
          ),
          iconSize: 36.r,
        ),
      );
}
