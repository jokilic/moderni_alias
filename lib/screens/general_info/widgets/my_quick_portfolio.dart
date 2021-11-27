import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../widgets/play_button.dart';
import '../general_info_controller.dart';

class MyQuickPortfolio extends StatelessWidget {
  final generalInfoController = Get.find<GeneralInfoController>();

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GestureDetector(
                onLongPress: generalInfoController.playBoomBaby,
                child: CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 85.r,
                  child: CircleAvatar(
                    backgroundImage: const AssetImage(josipImage),
                    radius: 82.r,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: PlayButton(
                text: 'aboutMeWebsiteString'.tr.toUpperCase(),
                horizontalPadding: 16.w,
                onPressed: () => launch(josipKilicWebsite),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: PlayButton(
                    text: 'aboutMeGitHubString'.tr.toUpperCase(),
                    horizontalPadding: 16.w,
                    onPressed: () => launch(josipGithubWebsite),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: PlayButton(
                    text: 'aboutMeEmailString'.tr.toUpperCase(),
                    horizontalPadding: 16.w,
                    onPressed: () => launch(josipKilicEmail),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
