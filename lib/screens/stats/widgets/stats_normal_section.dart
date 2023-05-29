import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/normal_game_stats/normal_game_stats.dart';
import '../../../widgets/game_title.dart';
import '../../normal_game_stats/normal_game_stats_screen.dart';
import '../stats_notifier.dart';
import 'stats_value_widget.dart';

class StatsNormalSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsNotifier = ref.watch(statsProvider.notifier);

    final now = DateTime.now();
    final sortedGames = List<NormalGameStats>.from(statsNotifier.normalGameStats)..sort((a, b) => a.startTime.difference(now).abs().compareTo(b.startTime.difference(now).abs()));

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

        if (statsNotifier.normalGameStats.isEmpty)
          StatsValueWidget(
            text: 'statsNormalNoGames'.tr(),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statsNotifier.normalGameStats.length,
            itemBuilder: (_, index) {
              final normalGame = sortedGames[index];
              final time = DateFormat('d. MMMM - HH:mm', context.locale.languageCode).format(normalGame.startTime);
              final textTime = timeago.format(normalGame.startTime);

              return StatsValueWidget(
                text: '$time\n($textTime)',
                value: index + 1,
                valueLeft: true,
                onPressed: () => Navigator.of(context).pushNamed(
                  NormalGameStatsScreen.routeName,
                  arguments: normalGame,
                ),
              );
            },
          ),
      ],
    );
  }
}
