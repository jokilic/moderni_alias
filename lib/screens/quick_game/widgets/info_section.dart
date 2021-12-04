import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class InfoSection extends StatelessWidget {
  final Function() exitGame;
  final int correctAnswers;
  final int wrongAnswers;

  const InfoSection({
    required this.exitGame,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 50.h,
        margin: EdgeInsets.only(top: 4.h),
        child: Stack(
          children: [
            Positioned(
              left: 12.w,
              child: IconButton(
                onPressed: exitGame,
                icon: Icon(
                  Icons.close,
                  color: ModerniAliasColors.whiteColor,
                  size: 30.r,
                ),
              ),
            ),
            Positioned(
              right: 20.w,
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
          ],
        ),
      );
}
