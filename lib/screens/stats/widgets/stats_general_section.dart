import 'package:flutter/material.dart';

import '../../../widgets/game_title.dart';
import '../stats_controller.dart';
import 'stats_value_widget.dart';

class StatsGeneralSection extends GetView<StatsController> {
  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ///
          /// GENERAL
          ///
          GameTitle(
            'statsGeneralTitle'.tr,
            smallTitle: true,
          ),

          const SizedBox(height: 12),

          StatsValueWidget(
            text: 'statsGeneralNormalGames'.tr,
            value: controller.totalNormalGames,
          ),
          StatsValueWidget(
            text: 'statsGeneralQuickGames'.tr,
            value: controller.totalQuickGames,
          ),
          StatsValueWidget(
            text: 'statsGeneralAllGames'.tr,
            value: controller.totalNormalGames + controller.totalQuickGames,
            bigText: true,
          ),

          const SizedBox(height: 32),

          ///
          /// CORRECT & WRONG ANSWERS
          ///
          GameTitle(
            'statsGeneralCorrectWrong'.tr,
            smallTitle: true,
          ),

          const SizedBox(height: 12),

          StatsValueWidget(
            text: 'statsCorrect'.tr,
            value: controller.totalCorrectAnswersNormalGames + controller.totalCorrectAnswersQuickGames,
          ),
          StatsValueWidget(
            text: 'statsWrong'.tr,
            value: controller.totalWrongAnswersNormalGames + controller.totalWrongAnswersQuickGames,
          ),
          StatsValueWidget(
            text: 'statsAll'.tr,
            value: (controller.totalCorrectAnswersNormalGames + controller.totalCorrectAnswersQuickGames) +
                (controller.totalWrongAnswersNormalGames + controller.totalWrongAnswersQuickGames),
            bigText: true,
          ),

          const SizedBox(height: 32),

          ///
          /// AVERAGE ANSWERS PER GAME
          ///
          GameTitle(
            'statsGeneralAverageGame'.tr,
            smallTitle: true,
          ),

          const SizedBox(height: 12),

          StatsValueWidget(
            text: 'statsCorrect'.tr,
            value: controller.totalAverageCorrectAnswers,
          ),
          StatsValueWidget(
            text: 'statsWrong'.tr,
            value: controller.totalAverageWrongAnswers,
          ),
          StatsValueWidget(
            text: 'statsAll'.tr,
            value: controller.totalAverageAnswers,
            bigText: true,
          ),

          const SizedBox(height: 32),

          ///
          /// AVERAGE ANSWERS PER ROUND
          ///
          GameTitle(
            'statsGeneralAverageRound'.tr,
            smallTitle: true,
          ),

          const SizedBox(height: 12),

          StatsValueWidget(
            text: 'statsCorrect'.tr,
            value: controller.averageCorrectAnswersRounds,
          ),
          StatsValueWidget(
            text: 'statsWrong'.tr,
            value: controller.averageWrongAnswersRounds,
          ),
          StatsValueWidget(
            text: 'statsAll'.tr,
            value: controller.averageAnswersRounds,
            bigText: true,
          ),

          const SizedBox(height: 32),
        ],
      );
}
