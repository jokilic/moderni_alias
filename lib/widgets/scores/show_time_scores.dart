import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import './highscore_value.dart';
import '../../constants/enums.dart';
import '../../constants/images.dart';
import '../../constants/text_styles.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../screens/time_game/time_game_controller.dart';
import '../../util/providers.dart';
import '../animated_column.dart';
import '../animated_list_view.dart';
import 'played_word_value.dart';

void showTimeScores(
  BuildContext context, {
  required List<PlayedWord> playedWords,
  bool dismissible = true,
}) =>
    showModalBottomSheet(
      context: context,
      isDismissible: dismissible,
      builder: (context) => TimeScoresModal(
        playedWords: playedWords,
      ),
    );

class TimeScoresModal extends ConsumerWidget {
  final List<PlayedWord> playedWords;

  const TimeScoresModal({
    required this.playedWords,
  });

  String calculatePoints({required List<Round>? rounds, required int index}) {
    if ((rounds?.length ?? 0) > index) {
      final duration = Duration(seconds: rounds?[index].durationSeconds ?? 0);
      return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      return '00:00';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamsProvider);
    final rounds = ref.watch(timeGameProvider).timeGameStats.rounds;

    final timeGameTimer = ref.watch(timeGameTimerProvider);
    final duration = '${timeGameTimer.inMinutes.toString().padLeft(2, '0')}:${(timeGameTimer.inSeconds % 60).toString().padLeft(2, '0')}';

    final currentGame = ref.watch(currentGameProvider);

    final currentlyPlayingTeamIndex = teams.indexOf(ref.watch(currentlyPlayingTeamProvider));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 36,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ModerniAliasImages.backgroundImage,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.vertical(
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
            Text(
              'scoresModalString'.tr(),
              style: ModerniAliasTextStyles.scoresTitle,
            ),
            const SizedBox(height: 24),
            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: teams.length,
                itemBuilder: (_, index) => AnimatedListView(
                  fastAnimations: true,
                  index: index,
                  child: HighscoreValue(
                    teamName: teams[index].name,
                    points: currentlyPlayingTeamIndex == index && currentGame == Game.time
                        ? duration
                        : calculatePoints(
                            rounds: rounds,
                            index: index,
                          ),
                  ),
                ),
              ),
            ),

            ///
            /// WORDS FROM LAST ROUND
            ///
            if (playedWords.isNotEmpty) ...[
              Text(
                'playedWordsModalString'.tr(),
                style: ModerniAliasTextStyles.scoresTitle,
              ),
              const SizedBox(height: 24),
              AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
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
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
