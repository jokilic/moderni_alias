import 'package:flutter/material.dart';

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
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        childrenPadding: const EdgeInsets.only(top: 8, bottom: 16),
        leading: Container(
          padding: const EdgeInsets.all(6),
          constraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ModerniAliasColors.whiteColor,
          ),
          child: Text(
            '${widget.index + 1}',
            style: ModerniAliasTextStyles.statsNumber.copyWith(
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        subtitle: showSubtitle
            ? Text(
                '${widget.someWords}...',
                style: ModerniAliasTextStyles.stats.copyWith(
                  fontSize: 16,
                ),
              )
            : null,
        title: Text(
          '${widget.round.playingTeam?.name}',
          style: ModerniAliasTextStyles.stats.copyWith(
            fontSize: 24,
          ),
        ),
        trailing: AnimatedRotation(
          turns: turns,
          duration: ModerniAliasDurations.fastAnimation,
          curve: Curves.easeIn,
          child: const Icon(
            Icons.arrow_drop_down_circle,
            color: ModerniAliasColors.whiteColor,
            size: 32,
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
