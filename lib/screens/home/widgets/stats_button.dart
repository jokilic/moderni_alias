import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class StatsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => goToStatsScreen(context),
        end: 0.85,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            foregroundColor: ModerniAliasColors.whiteColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: Colors.black45,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'statsButtonString'.tr(),
              style: ModerniAliasTextStyles.howToPlayButton,
            ),
          ),
        ),
      );
}
