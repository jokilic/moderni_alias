import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../util/routing.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/background_image.dart';
import '../../../widgets/play_button.dart';
import 'stats_button.dart';

class HomePageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedColumn(
          children: [
            PlayButton(
              text: 'startButtonString'.tr().toUpperCase(),
              horizontalPadding: 40,
              onPressed: () => goToNormalGameSetupScreen(context),
            ),
            const SizedBox(height: 25),
            PlayButton(
              text: 'timeStartButtonString'.tr().toUpperCase(),
              horizontalPadding: 40,
              onPressed: () => goToTimeGameSetupScreen(context),
            ),
            const SizedBox(height: 25),
            PlayButton(
              text: 'quickStartButtonString'.tr().toUpperCase(),
              horizontalPadding: 40,
              onPressed: () => goToQuickGameScreen(context),
            ),
            const SizedBox(height: 25),
            Consumer(
              builder: (context, ref, child) => PlayButton(
                text: 'Change background'.toUpperCase(),
                horizontalPadding: 40,
                onPressed: ref.read(backgroundImageProvider.notifier).cycleBackgrounds,
              ),
            ),
            const SizedBox(height: 25),
            StatsButton(),
            const SizedBox(height: 50),
          ],
        ),
      );
}
