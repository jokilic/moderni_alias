import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../../widgets/play_button.dart';
import '../general_info_controller.dart';

class MyQuickPortfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: AnimatedColumn(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AnimatedGestureDetector(
                child: GestureDetector(
                  onLongPress: Get.find<GeneralInfoController>().playBoomBaby,
                  behavior: HitTestBehavior.translucent,
                  child: const CircleAvatar(
                    backgroundColor: ModerniAliasColors.whiteColor,
                    radius: 85,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        ModerniAliasImages.josipImage,
                      ),
                      radius: 82,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: PlayButton(
                text: 'aboutMeWebsiteString'.tr.toUpperCase(),
                horizontalPadding: 16,
                onPressed: () => launchUrl(
                  Uri.parse(ModerniAliasWebsites.josipKilicWebsite),
                  mode: LaunchMode.externalApplication,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlayButton(
                    text: 'aboutMeGitHubString'.tr.toUpperCase(),
                    horizontalPadding: 16,
                    onPressed: () => launchUrl(
                      Uri.parse(ModerniAliasWebsites.josipGithubWebsite),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlayButton(
                    text: 'aboutMeEmailString'.tr.toUpperCase(),
                    horizontalPadding: 16,
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
