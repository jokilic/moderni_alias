import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/game_title.dart';
import 'stats_value_widget.dart';

class StatsInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          GameTitle(
            'statsInfoGeneral'.tr,
            smallTitle: true,
          ),
          StatsValueWidget(
            text: 'statsInfoGeneralExplanation'.tr,
          ),
          SizedBox(height: 8.h),
          GameTitle(
            'statsInfoNormal'.tr,
            smallTitle: true,
          ),
          StatsValueWidget(
            text: 'statsInfoNormalExplanation'.tr,
          ),
          SizedBox(height: 8.h),
          GameTitle(
            'statsInfoQuick'.tr,
            smallTitle: true,
          ),
          StatsValueWidget(
            text: 'statsInfoQuickExplanation'.tr,
          ),
          SizedBox(height: 32.h),
        ],
      );
}
