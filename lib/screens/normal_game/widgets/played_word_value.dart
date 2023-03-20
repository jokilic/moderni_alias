import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../constants/strings.dart';
import '../../../constants/text_styles.dart';

class PlayedWordValue extends StatelessWidget {
  final String word;
  final Answer chosenAnswer;

  const PlayedWordValue({
    required this.word,
    required this.chosenAnswer,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Padding(
          padding: EdgeInsets.only(bottom: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 0.6.sw,
                child: Text(
                  word,
                  style: ModerniAliasTextStyles.highscore,
                ),
              ),
              SizedBox(width: 16.w),
              SizedBox(
                width: 0.1.sw,
                child: SvgPicture.asset(
                  chosenAnswer == Answer.correct ? ModerniAliasImages.correctImage : ModerniAliasImages.wrongImage,
                  colorFilter: const ColorFilter.mode(
                    ModerniAliasColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                  width: 24.r,
                  height: 24.r,
                ),
              ),
            ],
          ),
        ),
      );
}
