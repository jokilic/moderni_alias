import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../stats_controller.dart';
import 'stats_segmented_value_widget.dart';

class StatsSegmentedWidget extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(
          () => Row(
            children: [
              StatsSegmentedValueWidget(
                onPressed: () => controller.segmentedValuePressed(0),
                text: 'statsInfoGeneral'.tr,
                isActive: controller.currentIndex == 0 || controller.currentIndex == null,
              ),
              StatsSegmentedValueWidget(
                onPressed: () => controller.segmentedValuePressed(1),
                text: 'statsInfoNormal'.tr,
                isActive: controller.currentIndex == 1 || controller.currentIndex == null,
              ),
              StatsSegmentedValueWidget(
                onPressed: () => controller.segmentedValuePressed(2),
                text: 'statsInfoQuick'.tr,
                isActive: controller.currentIndex == 2 || controller.currentIndex == null,
              ),
            ],
          ),
        ),
      );
}
