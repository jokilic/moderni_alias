import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'stats_segmented_value_widget.dart';

class StatsSegmentedWidget extends StatelessWidget {
  final int? currentIndex;
  final Function(int value) segmentedValuePressed;

  const StatsSegmentedWidget({
    required this.currentIndex,
    required this.segmentedValuePressed,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            StatsSegmentedValueWidget(
              onPressed: () => segmentedValuePressed(0),
              text: 'statsInfoNormal'.tr(),
              isActive: currentIndex == 0 || currentIndex == null,
            ),
            StatsSegmentedValueWidget(
              onPressed: () => segmentedValuePressed(1),
              text: 'statsInfoTime'.tr(),
              isActive: currentIndex == 1 || currentIndex == null,
            ),
            StatsSegmentedValueWidget(
              onPressed: () => segmentedValuePressed(2),
              text: 'statsInfoQuick'.tr(),
              isActive: currentIndex == 2 || currentIndex == null,
            ),
          ],
        ),
      );
}
