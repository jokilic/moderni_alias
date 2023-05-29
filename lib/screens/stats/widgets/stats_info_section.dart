import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../widgets/game_title.dart';
import 'stats_value_widget.dart';

class StatsInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          GameTitle(
            'statsInfoGeneral'.tr(),
            smallTitle: true,
          ),
          StatsValueWidget(
            text: 'statsInfoGeneralExplanation'.tr(),
          ),
          const SizedBox(height: 8),
          GameTitle(
            'statsInfoNormal'.tr(),
            smallTitle: true,
          ),
          StatsValueWidget(
            text: 'statsInfoNormalExplanation'.tr(),
          ),
          const SizedBox(height: 8),
          GameTitle(
            'statsInfoQuick'.tr(),
            smallTitle: true,
          ),
          StatsValueWidget(
            text: 'statsInfoQuickExplanation'.tr(),
          ),
          const SizedBox(height: 32),
        ],
      );
}
