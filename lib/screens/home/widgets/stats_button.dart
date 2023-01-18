import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../widgets/animated_gesture_detector.dart';
import '../../stats/stats_screen.dart';

class StatsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedGestureDetector(
        onTap: () => Get.toNamed(
          StatsScreen.routeName,
        ),
        end: 0.8,
        child: IconButton(
          onPressed: null,
          icon: const Icon(
            Icons.table_chart,
            color: ModerniAliasColors.whiteColor,
          ),
          iconSize: 36.r,
        ),
      );
}
