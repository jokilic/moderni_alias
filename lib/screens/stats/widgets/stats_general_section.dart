import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/game_title.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsGeneralSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsNotifier = ref.watch(statsProvider.notifier);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ///
        /// GENERAL
        ///
        GameTitle(
          'statsGeneralTitle'.tr(),
          smallTitle: true,
        ),

        const SizedBox(height: 12),

        StatsValueWidget(
          text: 'statsGeneralNormalGames'.tr(),
          value: statsNotifier.totalNormalGames,
        ),
        StatsValueWidget(
          text: 'statsGeneralTimeGames'.tr(),
          value: statsNotifier.totalTimeGames,
        ),
        StatsValueWidget(
          text: 'statsGeneralQuickGames'.tr(),
          value: statsNotifier.totalQuickGames,
        ),
        StatsValueWidget(
          text: 'statsGeneralAllGames'.tr(),
          value: statsNotifier.totalNormalGames + statsNotifier.totalTimeGames + statsNotifier.totalQuickGames,
          bigText: true,
        ),

        const SizedBox(height: 32),

        ///
        /// CORRECT & WRONG ANSWERS
        ///
        GameTitle(
          'statsGeneralCorrectWrong'.tr(),
          smallTitle: true,
        ),

        const SizedBox(height: 12),

        StatsValueWidget(
          text: 'statsCorrect'.tr(),
          value: statsNotifier.totalCorrectAnswersNormalGames + statsNotifier.totalCorrectAnswersTimeGames + statsNotifier.totalCorrectAnswersQuickGames,
        ),
        StatsValueWidget(
          text: 'statsWrong'.tr(),
          value: statsNotifier.totalWrongAnswersNormalGames + statsNotifier.totalWrongAnswersTimeGames + statsNotifier.totalWrongAnswersQuickGames,
        ),
        StatsValueWidget(
          text: 'statsAll'.tr(),
          value: (statsNotifier.totalCorrectAnswersNormalGames + statsNotifier.totalCorrectAnswersTimeGames + statsNotifier.totalCorrectAnswersQuickGames) +
              (statsNotifier.totalWrongAnswersNormalGames + statsNotifier.totalWrongAnswersTimeGames + statsNotifier.totalWrongAnswersQuickGames),
          bigText: true,
        ),

        const SizedBox(height: 32),

        ///
        /// AVERAGE ANSWERS PER GAME
        ///
        GameTitle(
          'statsGeneralAverageGame'.tr(),
          smallTitle: true,
        ),

        const SizedBox(height: 12),

        StatsValueWidget(
          text: 'statsCorrect'.tr(),
          value: statsNotifier.totalAverageCorrectAnswers,
        ),
        StatsValueWidget(
          text: 'statsWrong'.tr(),
          value: statsNotifier.totalAverageWrongAnswers,
        ),
        StatsValueWidget(
          text: 'statsAll'.tr(),
          value: statsNotifier.totalAverageAnswers,
          bigText: true,
        ),

        SizedBox(
          height: MediaQuery.paddingOf(context).bottom + 40,
        ),
      ],
    );
  }
}
