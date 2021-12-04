import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/strings.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';

class HeroTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: AnimatedColumn(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 32.w),
              child: SvgPicture.asset(
                ModerniAliasImages.conversationUpImage,
                width: 70.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'appNameFirstString'.tr,
                  style: ModerniAliasTextStyles.appNameFirst,
                  children: [
                    TextSpan(
                      text: 'appNameSecondString'.tr,
                      style: ModerniAliasTextStyles.appNameSecond,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 32.w),
              child: SvgPicture.asset(
                ModerniAliasImages.conversationDownImage,
                width: 70.w,
              ),
            ),
          ],
        ),
      );
}
