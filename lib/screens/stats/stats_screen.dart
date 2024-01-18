import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/durations.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
import 'stats_controller.dart';
import 'widgets/stats_general_section.dart';
import 'widgets/stats_normal_section.dart';
import 'widgets/stats_quick_section.dart';
import 'widgets/stats_segmented_widget.dart';
import 'widgets/stats_time_section.dart';

class StatsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(statsProvider);
    final statsNotifier = ref.watch(statsProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  HeroTitle(smallText: 'statsTitle'.tr()),
                  const SizedBox(height: 40),
                  StatsSegmentedWidget(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: ModerniAliasDurations.animation,
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeIn,
                      child: currentIndex != null
                          ? PageView(
                              controller: statsNotifier.pageController,
                              onPageChanged: statsNotifier.pageChanged,
                              children: [
                                StatsNormalSection(),
                                StatsTimeSection(),
                                StatsQuickSection(),
                              ],
                            )
                          : StatsGeneralSection(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
