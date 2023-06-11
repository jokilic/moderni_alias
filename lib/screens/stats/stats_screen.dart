import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
import 'stats_controller.dart';
import 'widgets/stats_general_section.dart';
import 'widgets/stats_info_section.dart';
import 'widgets/stats_normal_section.dart';
import 'widgets/stats_quick_section.dart';
import 'widgets/stats_segmented_widget.dart';

class StatsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = context.locale.languageCode;

    final currentIndex = ref.watch(statsProvider(locale));
    final statsNotifier = ref.watch(statsProvider(locale).notifier);

    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                HeroTitle(smallText: 'statsTitle'.tr()),
                const SizedBox(height: 32),
                StatsSegmentedWidget(),
                const SizedBox(height: 24),
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
                              StatsGeneralSection(),
                              StatsNormalSection(),
                              StatsQuickSection(),
                            ],
                          )
                        : StatsInfoSection(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
