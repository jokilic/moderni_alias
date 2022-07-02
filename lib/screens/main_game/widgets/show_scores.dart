import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import './highscore_value.dart';
import '../../../constants/strings.dart';
import '../../../constants/text_styles.dart';
import '../../../models/team.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/animated_list_view.dart';

void showScores({
  required BuildContext context,
  required List<Team> teams,
  bool dismissible = true,
}) =>
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 36.h,
          bottom: 24.h,
        ),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(
              ModerniAliasImages.backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.r),
          ),
        ),
        child: AnimatedColumn(
          fastAnimations: true,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'scoresModalString'.tr,
              style: ModerniAliasTextStyles.scoresTitle,
            ),
            SizedBox(height: 24.h),
            AnimationLimiter(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: teams.length,
                itemBuilder: (context, index) => AnimatedListView(
                  fastAnimations: true,
                  index: index,
                  child: HighscoreValue(
                    teamName: teams[index].name,
                    points: teams[index].points,
                  ),
                ),
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
      isDismissible: dismissible,
    );
