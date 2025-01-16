import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../constants/text_styles.dart';
import '../../models/played_word/played_word.dart';
import '../../models/team/team.dart';
import '../animated_column.dart';
import '../animated_list_view.dart';
import './highscore_value.dart';
import 'played_word_value.dart';

void showScores(
  BuildContext context, {
  required List<PlayedWord> playedWords,
  required String backgroundImage,
  List<Team>? teams,
  bool dismissible = true,
}) {
  if (teams != null || playedWords.isNotEmpty) {
    showModalBottomSheet(
      context: context,
      isDismissible: dismissible,
      builder: (context) => ScoresModal(
        teams: teams,
        playedWords: playedWords,
        backgroundImage: backgroundImage,
      ),
    );
  }
}

class ScoresModal extends StatelessWidget {
  final List<Team>? teams;
  final List<PlayedWord> playedWords;
  final String backgroundImage;

  const ScoresModal({
    required this.teams,
    required this.playedWords,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 36,
          bottom: 24,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
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
                  'scoresModalString'.tr(),
                  style: ModerniAliasTextStyles.scoresTitle,
                ),
                AnimationLimiter(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 24,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: teams!.length,
                    itemBuilder: (_, index) => AnimatedListView(
                      fastAnimations: true,
                      index: index,
                      child: HighscoreValue(
                        teamName: teams![index].name,
                        points: '${teams![index].points}',
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                  ),
                ),
              ],

              ///
              /// WORDS FROM LAST ROUND
              ///
              if (playedWords.isNotEmpty) ...[
                Text(
                  'playedWordsModalString'.tr(),
                  style: ModerniAliasTextStyles.scoresTitle,
                ),
                AnimationLimiter(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 56,
                      vertical: 24,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: playedWords.length,
                    itemBuilder: (_, index) => AnimatedListView(
                      fastAnimations: true,
                      index: index,
                      child: PlayedWordValue(
                        word: playedWords[index].word,
                        chosenAnswer: playedWords[index].chosenAnswer,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
}
