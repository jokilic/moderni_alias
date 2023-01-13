import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../widgets/background_image.dart';
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
                  SizedBox(height: 32.h),
                  StatsSegmentedWidget(),
                  SizedBox(height: 32.h),
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
