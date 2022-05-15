import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../stats/stats_screen.dart';

class StatsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.table_chart),
        iconSize: 36.r,
        onPressed: () => Get.toNamed(
          StatsScreen.routeName,
        ),
      );
}
