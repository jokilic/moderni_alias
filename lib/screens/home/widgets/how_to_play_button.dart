import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../how_to_play/how_to_play_screen.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => Get.toNamed(
          HowToPlayScreen.routeName,
        ),
        end: 0.85,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            foregroundColor: ModerniAliasColors.whiteColor,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 2.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            backgroundColor: Colors.black45,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Text(
              'howToPlayButtonString'.tr,
              style: ModerniAliasTextStyles.howToPlayButton,
            ),
          ),
        ),
      );
}
