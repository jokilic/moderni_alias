import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../models/round/round.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../stats/stats_controller.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';
import '../stats/widgets/stats_words_expansion_widget.dart';
import 'time_game_stats_controller.dart';

class TimeGameStatsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeGameStatsState = ref.watch(statsProvider.notifier).activeTimeGameStats;

    /// `TimeGameStats` are properly passed, show screen
    if (timeGameStatsState != null) {
      final timeGameStatsPro = ref.watch(timeGameStatsProvider(timeGameStatsState));
      final timeGameStats = timeGameStatsPro.timeGameStats;

      final locale = context.locale.languageCode;

      final date = DateFormat('d. MMMM', locale).format(timeGameStats.startTime);
      final time = DateFormat('HH:mm', locale).format(timeGameStats.startTime);
      final textTime = timeago.format(timeGameStats.startTime, locale: locale);
      final language = timeGameStats.language == Flag.croatia ? 'dictionaryCroatianString'.tr() : 'dictionaryEnglishString'.tr();
      final sortedRounds = List<Round>.from(timeGameStats.rounds)..sort((a, b) => a.durationSeconds?.compareTo(b.durationSeconds ?? 0) ?? 0);

      return Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 32),
                  const HeroTitle(),
                  const SizedBox(height: 24),
                  GameTitle(
                    'statsWhoWonTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sortedRounds.length,
                    itemBuilder: (_, index) {
                      final round = sortedRounds[index];

                      final isFastest = timeGameStatsPro.calculateRoundFastest(
                        passedRound: round,
                        fastestRound: sortedRounds.first,
                      );

                      final duration =
                          '${Duration(seconds: round.durationSeconds ?? 0).inMinutes.toString().padLeft(2, '0')}:${(Duration(seconds: round.durationSeconds ?? 0).inSeconds % 60).toString().padLeft(2, '0')}';

                      return StatsValueWidget(
                        text: round.playingTeam?.name ?? '',
                        textValue: duration,
                        bigText: true,
                        yellowCircle: isFastest,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsWhenTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  StatsTextIconWidget(
                    text: 'statsWhenText'.tr(
                      namedArgs: {
                        'date': date,
                        'time': time,
                        'textTime': textTime,
                      },
                    ),
                    icon: ModerniAliasIcons.clockImage,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsLanguageTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  StatsTextIconWidget(
                    text: 'statsLanguageText'.tr(
                      namedArgs: {
                        'language': language,
                      },
                    ),
                    icon: timeGameStats.language == Flag.croatia ? ModerniAliasIcons.croatiaImageColor : ModerniAliasIcons.unitedKingdomImageColor,
                    size: 58,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsNumberOfWordsTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  StatsTextIconWidget(
                    text: 'statsNumberOfWordsText'.tr(
                      namedArgs: {
                        'lengthOfWords': '${timeGameStats.numberOfWords}',
                      },
                    ),
                    icon: ModerniAliasIcons.pointsImage,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsWordsTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: timeGameStats.rounds.length,
                    itemBuilder: (_, index) {
                      final round = timeGameStats.rounds[index];
                      final someWords = round.playedWords.take(3).map((word) => word.word).join(', ');

                      return StatsWordsExpansionWidget(
                        index: index,
                        round: round,
                        someWords: someWords,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      );
    }

    /// `TimeGameStats` failed to load, show error screen
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 32),
                const HeroTitle(),
                const SizedBox(height: 24),
                GameTitle(
                  'statsFailedToLoad'.tr(),
                  smallTitle: true,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
