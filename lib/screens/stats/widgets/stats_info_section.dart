import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/game_title.dart';
import 'stats_value_widget.dart';

class StatsInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const GameTitle(
            'General',
            smallTitle: true,
          ),
          const StatsValueWidget(
            text: 'Section which shows general info about played games.',
          ),
          SizedBox(height: 8.h),
          const GameTitle(
            'Normal',
            smallTitle: true,
          ),
          const StatsValueWidget(
            text: "Section which shows info about every normal game you've played.",
          ),
          SizedBox(height: 8.h),
          const GameTitle(
            'Quick',
            smallTitle: true,
          ),
          const StatsValueWidget(
            text: "Section which shows info about every quick game you've played.",
          ),
        ],
      );
}
