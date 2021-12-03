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
        margin: EdgeInsets.only(top: 24.h),
        child: Stack(
          children: [
            Positioned(
              left: -10.w,
              top: -10.h,
              child: FlatButton(
                onPressed: exitGame,
                child: Icon(
                  Icons.close,
                  color: ModerniAliasColors.whiteColor,
                  size: 30.r,
                ),
              ),
            ),
            Positioned(
              right: 20.w,
              top: -10.h,
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
