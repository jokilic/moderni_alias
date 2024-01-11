import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../constants/websites.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../../widgets/play_button.dart';
import '../general_info_controller.dart';
import 'video_widget.dart';

class MyQuickPortfolio extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: AnimatedColumn(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AnimatedGestureDetector(
                child: GestureDetector(
                  onLongPress: ref.read(generalInfoProvider).playBoomBaby,
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ModerniAliasColors.white,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: VideoWidget(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: PlayButton(
                text: 'aboutMeWebsiteString'.tr().toUpperCase(),
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
                    text: 'aboutMeGitHubString'.tr().toUpperCase(),
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
                    text: 'aboutMeEmailString'.tr().toUpperCase(),
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
