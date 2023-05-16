import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
import 'stats_controller.dart';
import 'widgets/stats_general_section.dart';
import 'widgets/stats_info_section.dart';
import 'widgets/stats_normal_section.dart';
import 'widgets/stats_quick_section.dart';
import 'widgets/stats_segmented_widget.dart';

class StatsScreen extends GetView<StatsController> {
  static const routeName = '/stats-screen';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  HeroTitle(smallText: 'statsTitle'.tr),
                  const SizedBox(height: 32),
                  StatsSegmentedWidget(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Obx(
                      () => AnimatedSwitcher(
                        duration: ModerniAliasDurations.animation,
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeIn,
                        child: controller.currentIndex != null
                            ? PageView(
                                controller: controller.pageController,
                                onPageChanged: controller.pageChanged,
                                children: [
                                  StatsGeneralSection(),
                                  StatsNormalSection(),
                                  StatsQuickSection(),
                                ],
                              )
                            : StatsInfoSection(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
