import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/time_game_stats/time_game_stats.dart';
import '../../../util/routing.dart';
import '../../../widgets/game_title.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsTimeSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsNotifier = ref.watch(statsProvider.notifier);

    final now = DateTime.now();
    final sortedGames = List<TimeGameStats>.from(statsNotifier.timeGameStats)..sort((a, b) => a.startTime.difference(now).abs().compareTo(b.startTime.difference(now).abs()));

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// TIME GAMES
        ///
        GameTitle(
          'statsGeneralTimeGames'.tr().toUpperCase(),
        ),

        const SizedBox(height: 12),

        if (statsNotifier.timeGameStats.isEmpty)
          StatsValueWidget(
            text: 'statsTimeNoGames'.tr(),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statsNotifier.timeGameStats.length,
            itemBuilder: (_, index) {
              final locale = context.locale.languageCode;

              final timeGame = sortedGames[index];
              final time = DateFormat('d. MMMM - HH:mm', locale).format(timeGame.startTime);
              final textTime = timeago.format(timeGame.startTime, locale: locale);

              return StatsValueWidget(
                text: '$time\n($textTime)',
                value: index + 1,
                valueLeft: true,
                onPressed: () {
                  ref.read(statsProvider.notifier).activeTimeGameStats = timeGame;
                  openStatsTimeGame(context);
                },
              );
            },
          ),
      ],
    );
  }
}
