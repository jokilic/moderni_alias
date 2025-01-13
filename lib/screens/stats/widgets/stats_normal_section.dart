import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/normal_game_stats/normal_game_stats.dart';
import '../../../util/routing.dart';
import '../../../widgets/game_title.dart';
import 'stats_value_widget.dart';

class StatsNormalSection extends StatelessWidget {
  final List<NormalGameStats> normalGameStats;

  const StatsNormalSection({
    required this.normalGameStats,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sortedGames = List<NormalGameStats>.from(normalGameStats)..sort((a, b) => a.startTime.difference(now).abs().compareTo(b.startTime.difference(now).abs()));

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// NORMAL GAMES
        ///
        GameTitle(
          'statsGeneralNormalGames'.tr().toUpperCase(),
        ),

        const SizedBox(height: 12),

        if (normalGameStats.isEmpty)
          StatsValueWidget(
            text: 'statsNormalNoGames'.tr(),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: normalGameStats.length,
            itemBuilder: (_, index) {
              final locale = context.locale.languageCode;

              final normalGame = sortedGames[index];
              final time = DateFormat('d. MMMM - HH:mm', locale).format(normalGame.startTime);
              final textTime = timeago.format(normalGame.startTime, locale: locale);

              return StatsValueWidget(
                text: '$time\n($textTime)',
                value: index + 1,
                valueLeft: true,
                onPressed: () => openStatsNormalGame(
                  context,
                  normalGameStats: normalGame,
                ),
              );
            },
          ),
      ],
    );
  }
}
