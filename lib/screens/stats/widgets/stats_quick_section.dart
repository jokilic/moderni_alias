import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/quick_game_stats/quick_game_stats.dart';
import '../../../util/routing.dart';
import '../../../widgets/game_title.dart';
import 'stats_value_widget.dart';

class StatsQuickSection extends StatelessWidget {
  final List<QuickGameStats> quickGameStats;

  const StatsQuickSection({
    required this.quickGameStats,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sortedGames = List<QuickGameStats>.from(quickGameStats)..sort((a, b) => a.startTime.difference(now).abs().compareTo(b.startTime.difference(now).abs()));

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// QUICK GAMES
        ///
        GameTitle(
          'statsGeneralQuickGames'.tr().toUpperCase(),
        ),

        const SizedBox(height: 12),

        if (quickGameStats.isEmpty)
          StatsValueWidget(
            text: 'statsQuickNoGames'.tr(),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quickGameStats.length,
            itemBuilder: (_, index) {
              final locale = context.locale.languageCode;

              final quickGame = sortedGames[index];
              final time = DateFormat('d. MMMM - HH:mm', locale).format(quickGame.startTime);
              final textTime = timeago.format(quickGame.startTime, locale: locale);

              return StatsValueWidget(
                text: '$time\n($textTime)',
                value: index + 1,
                valueLeft: true,
                onPressed: () => openStatsQuickGame(
                  context,
                  quickGameStats: quickGame,
                ),
              );
            },
          ),
      ],
    );
  }
}
