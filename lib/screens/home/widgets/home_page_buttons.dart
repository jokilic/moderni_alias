import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/play_button.dart';
import 'stats_button.dart';

class HomePageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedColumn(
          children: [
            PlayButton(
              text: 'startButtonString'.tr().toUpperCase(),
              horizontalPadding: 44,
              onPressed: () => goToStartGameScreen(context),
            ),
            const SizedBox(height: 25),
            PlayButton(
              text: 'quickStartButtonString'.tr().toUpperCase(),
              onPressed: () => goToQuickGameScreen(context),
            ),
            const SizedBox(height: 25),
            StatsButton(),
            const SizedBox(height: 50),
          ],
        ),
      );
}
