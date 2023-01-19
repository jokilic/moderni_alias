import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class QuickGameInfoSection extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final Function() exitGame;
  final Function() showScores;

  const QuickGameInfoSection({
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.exitGame,
    required this.showScores,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 50.h,
        margin: EdgeInsets.only(top: 24.h),
        child: Stack(
          children: [
            Positioned(
              left: 12.w,
              child: IconButton(
                onPressed: exitGame,
                icon: Icon(
                  Icons.close_rounded,
                  color: ModerniAliasColors.whiteColor,
                  size: 30.r,
                ),
              ),
            ),
            Positioned(
              right: 20.w,
              child: GestureDetector(
                onTap: showScores,
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    Text(
                      wrongAnswers.toString(),
                      style: ModerniAliasTextStyles.quickWrongScore,
                    ),
                    SizedBox(width: 10.h),
                    Text(
                      correctAnswers.toString(),
                      style: ModerniAliasTextStyles.quickCorrectScore,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
