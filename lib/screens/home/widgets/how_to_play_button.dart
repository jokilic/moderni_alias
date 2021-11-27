import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../how_to_play/how_to_play_screen.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: () => Get.toNamed(
          HowToPlayScreen.routeName,
        ),
        color: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Text(
            'howToPlayButtonString'.tr,
            style: TextStyle(
              fontSize: 13.r,
              color: whiteColor,
            ),
          ),
        ),
      );
}
