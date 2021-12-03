import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './highscore_value.dart';
import '../../../constants/strings.dart';
import '../../../models/team.dart';

void showScores({required BuildContext context, required List<Team> teams}) => Get.bottomSheet(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'scoresModalString'.tr,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 24.h),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: teams.length,
              itemBuilder: (context, index) => HighscoreValue(
                teamName: teams[index].name,
                points: teams[index].points,
              ),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
