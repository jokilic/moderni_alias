import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/text_styles.dart';

class HighscoreValue extends StatelessWidget {
  final String teamName;
  final int points;

  const HighscoreValue({
    required this.teamName,
    required this.points,
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
                width: 0.5.sw,
                child: Text(
                  teamName,
                  style: ModerniAliasTextStyles.highscore,
                ),
              ),
              SizedBox(
                width: 0.1.sw,
                child: Text(
                  points.toString(),
                  textAlign: TextAlign.center,
                  style: ModerniAliasTextStyles.highscore,
                ),
              ),
            ],
          ),
        ),
      );
}
