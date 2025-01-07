import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';
import '../../../util/routing.dart';
import '../../../widgets/animated_gesture_detector.dart';

class StatsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => openStats(context),
        end: 0.85,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            textStyle: ModerniAliasTextStyles.howToPlayButton,
            backgroundColor: ModerniAliasColors.black.withValues(alpha: 0.35),
          ),
          child: Text('statsButtonString'.tr()),
        ),
      );
}
