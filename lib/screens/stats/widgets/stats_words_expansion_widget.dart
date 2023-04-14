import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../constants/text_styles.dart';
import '../../../models/round/round.dart';
import '../../normal_game/widgets/played_word_value.dart';

class StatsWordsExpansionWidget extends StatefulWidget {
  final int index;
  final Round round;
  final String someWords;

  const StatsWordsExpansionWidget({
    required this.index,
    required this.round,
    required this.someWords,
  });

  @override
  State<StatsWordsExpansionWidget> createState() => _StatsWordsExpansionWidgetState();
}

class _StatsWordsExpansionWidgetState extends State<StatsWordsExpansionWidget> {
  var showSubtitle = true;
  var turns = 0.0;

  @override
  Widget build(BuildContext context) => ExpansionTile(
        onExpansionChanged: (value) => setState(() {
          showSubtitle = !value;
          turns = value ? 0.5 : 0;
        }),
        shape: const RoundedRectangleBorder(),
        tilePadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        childrenPadding: EdgeInsets.only(top: 8.h, bottom: 16.h),
        leading: Container(
          padding: EdgeInsets.all(6.r),
          constraints: BoxConstraints(
            minHeight: 36.r,
            minWidth: 36.r,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ModerniAliasColors.whiteColor,
          ),
          child: Text(
            '${widget.index + 1}',
            style: ModerniAliasTextStyles.statsNumber.copyWith(
              fontSize: 24.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        subtitle: showSubtitle
            ? Text(
                '${widget.someWords}...',
                style: ModerniAliasTextStyles.stats.copyWith(
                  fontSize: 16.sp,
                ),
              )
            : null,
        title: Text(
          '${widget.round.playingTeam?.name}',
          style: ModerniAliasTextStyles.stats.copyWith(
            fontSize: 24.sp,
          ),
        ),
        trailing: AnimatedRotation(
          turns: turns,
          duration: ModerniAliasDurations.fastAnimation,
          curve: Curves.easeIn,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: ModerniAliasColors.whiteColor,
            size: 32.r,
          ),
        ),
        children: List.generate(
          widget.round.playedWords.length,
          (index) {
            final playedWord = widget.round.playedWords[index];

            return PlayedWordValue(
              word: playedWord.word,
              chosenAnswer: playedWord.chosenAnswer,
            );
          },
        ),
      );
}
