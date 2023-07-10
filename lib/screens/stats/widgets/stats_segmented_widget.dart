import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stats_controller.dart';
import 'stats_segmented_value_widget.dart';

class StatsSegmentedWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(statsProvider);
    final statsNotifier = ref.watch(statsProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          StatsSegmentedValueWidget(
            onPressed: () => statsNotifier.segmentedValuePressed(0),
            text: 'statsInfoNormal'.tr(),
            isActive: currentIndex == 0 || currentIndex == null,
          ),
          StatsSegmentedValueWidget(
            onPressed: () => statsNotifier.segmentedValuePressed(1),
            text: 'statsInfoTime'.tr(),
            isActive: currentIndex == 1 || currentIndex == null,
          ),
          StatsSegmentedValueWidget(
            onPressed: () => statsNotifier.segmentedValuePressed(2),
            text: 'statsInfoQuick'.tr(),
            isActive: currentIndex == 2 || currentIndex == null,
          ),
        ],
      ),
    );
  }
}
