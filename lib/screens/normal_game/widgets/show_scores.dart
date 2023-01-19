import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import './highscore_value.dart';
import '../../../constants/strings.dart';
import '../../../constants/text_styles.dart';
import '../../../models/played_word/played_word.dart';
import '../../../models/team/team.dart';
import '../../../widgets/animated_column.dart';
import '../../../widgets/animated_list_view.dart';
import 'played_word_value.dart';

void showScores({
  required List<PlayedWord> playedWords,
  List<Team>? teams,
  bool dismissible = true,
}) {
  if (teams != null || playedWords.isNotEmpty) {
    Get.bottomSheet(
      isDismissible: dismissible,
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: AnimatedColumn(
            fastAnimations: true,
            mainAxisSize: MainAxisSize.min,
            children: [
              ///
              /// CURRENT SCORES
              ///
              if (teams != null) ...[
                Text(
                  'scoresModalString'.tr,
                  style: ModerniAliasTextStyles.scoresTitle,
                ),
                SizedBox(height: 24.h),
                AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
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
                  ),
                ),
              ],

              ///
              /// WORDS FROM LAST ROUND
              ///
              if (playedWords.isNotEmpty) ...[
                if (teams != null) SizedBox(height: 40.h),
                Text(
                  'playedWordsModalString'.tr,
                  style: ModerniAliasTextStyles.scoresTitle,
                ),
                SizedBox(height: 24.h),
                AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: playedWords.length,
                    itemBuilder: (context, index) => AnimatedListView(
                      fastAnimations: true,
                      index: index,
                      child: PlayedWordValue(
                        word: playedWords[index].word,
                        chosenAnswer: playedWords[index].chosenAnswer,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
