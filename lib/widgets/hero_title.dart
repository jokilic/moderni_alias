import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constants/strings.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';

class HeroTitle extends StatelessWidget {
  final String? smallText;

  const HeroTitle({
    this.smallText,
  });

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 12.h,
                    bottom: smallText == null ? 12.h : 0,
                  ),
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
                if (smallText != null)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 16.h,
                      right: 8.w,
                    ),
                    child: Text(
                      smallText!,
                      style: ModerniAliasTextStyles.smallHero,
                      textAlign: TextAlign.end,
                    ),
                  ),
              ],
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
