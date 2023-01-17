import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/play_button.dart';
import '../general_info_controller.dart';

class MyQuickPortfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        child: AnimatedColumn(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GestureDetector(
                onLongPress: Get.find<GeneralInfoController>().playBoomBaby,
                behavior: HitTestBehavior.translucent,
                child: CircleAvatar(
                  backgroundColor: ModerniAliasColors.whiteColor,
                  radius: 85.r,
                  child: CircleAvatar(
                    backgroundImage: const AssetImage(
                      ModerniAliasImages.josipImage,
                    ),
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
                onPressed: () => launchUrl(
                  Uri.parse(ModerniAliasWebsites.josipKilicWebsite),
                  mode: LaunchMode.externalApplication,
                ),
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
                    onPressed: () => launchUrl(
                      Uri.parse(ModerniAliasWebsites.josipGithubWebsite),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: PlayButton(
                    text: 'aboutMeEmailString'.tr.toUpperCase(),
                    horizontalPadding: 16.w,
                    onPressed: () => launchUrl(
                      Uri.parse(ModerniAliasWebsites.josipKilicEmail),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
