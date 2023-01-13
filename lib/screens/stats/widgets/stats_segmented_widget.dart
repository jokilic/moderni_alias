import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../stats_controller.dart';
import 'stats_segmented_value_widget.dart';

class StatsSegmentedWidget extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Obx(
          () => Row(
            children: [
              StatsSegmentedValueWidget(
                onPressed: () => controller.segmentedValuePressed(0),
                text: 'General',
                isActive: controller.currentIndex == 0,
              ),
              StatsSegmentedValueWidget(
                onPressed: () => controller.segmentedValuePressed(1),
                text: 'Normal',
                isActive: controller.currentIndex == 1,
              ),
              StatsSegmentedValueWidget(
                onPressed: () => controller.segmentedValuePressed(2),
                text: 'Quick',
                isActive: controller.currentIndex == 2,
              ),
            ],
          ),
        ),
      );
}
