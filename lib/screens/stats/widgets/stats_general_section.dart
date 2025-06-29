import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../widgets/game_title.dart';
import 'stats_value_widget.dart';

class StatsGeneralSection extends StatelessWidget {
  final int totalNormalGames;
  final int totalTimeGames;
  final int totalQuickGames;
  final int totalCorrectAnswersNormalGames;
  final int totalCorrectAnswersTimeGames;
  final int totalCorrectAnswersQuickGames;
  final int totalWrongAnswersNormalGames;
  final int totalWrongAnswersTimeGames;
  final int totalWrongAnswersQuickGames;
  final int totalAverageCorrectAnswers;
  final int totalAverageWrongAnswers;
  final int totalAverageAnswers;

  const StatsGeneralSection({
    required this.totalNormalGames,
    required this.totalTimeGames,
    required this.totalQuickGames,
    required this.totalCorrectAnswersNormalGames,
    required this.totalCorrectAnswersTimeGames,
    required this.totalCorrectAnswersQuickGames,
    required this.totalWrongAnswersNormalGames,
    required this.totalWrongAnswersTimeGames,
    required this.totalWrongAnswersQuickGames,
    required this.totalAverageCorrectAnswers,
    required this.totalAverageWrongAnswers,
    required this.totalAverageAnswers,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
        value: totalNormalGames,
      ),
      StatsValueWidget(
        text: 'statsGeneralTimeGames'.tr(),
        value: totalTimeGames,
      ),
      StatsValueWidget(
        text: 'statsGeneralQuickGames'.tr(),
        value: totalQuickGames,
      ),
      StatsValueWidget(
        text: 'statsGeneralAllGames'.tr(),
        value: totalNormalGames + totalTimeGames + totalQuickGames,
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
        value: totalCorrectAnswersNormalGames + totalCorrectAnswersTimeGames + totalCorrectAnswersQuickGames,
      ),
      StatsValueWidget(
        text: 'statsWrong'.tr(),
        value: totalWrongAnswersNormalGames + totalWrongAnswersTimeGames + totalWrongAnswersQuickGames,
      ),
      StatsValueWidget(
        text: 'statsAll'.tr(),
        value:
            (totalCorrectAnswersNormalGames + totalCorrectAnswersTimeGames + totalCorrectAnswersQuickGames) +
            (totalWrongAnswersNormalGames + totalWrongAnswersTimeGames + totalWrongAnswersQuickGames),
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
        value: totalAverageCorrectAnswers,
      ),
      StatsValueWidget(
        text: 'statsWrong'.tr(),
        value: totalAverageWrongAnswers,
      ),
      StatsValueWidget(
        text: 'statsAll'.tr(),
        value: totalAverageAnswers,
        bigText: true,
      ),
      const SizedBox(height: 40),
    ],
  );
}
