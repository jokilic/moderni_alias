import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../models/team/team.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../stats/stats_controller.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';
import '../stats/widgets/stats_words_expansion_widget.dart';
import 'normal_game_stats_controller.dart';

class NormalGameStatsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final normalGameStatsState = ref.watch(statsProvider.notifier).activeNormalGameStats;

    /// `NormalGameStats` are properly passed, show screen
    if (normalGameStatsState != null) {
      final normalGameStatsPro = ref.watch(normalGameStatsProvider(normalGameStatsState));
      final normalGameStats = normalGameStatsPro.normalGameStats;

      final locale = context.locale.languageCode;

      final date = DateFormat('d. MMMM', locale).format(normalGameStats.startTime);
      final time = DateFormat('HH:mm', locale).format(normalGameStats.startTime);
      final textTime = timeago.format(normalGameStats.startTime, locale: locale);
      final language = normalGameStats.language == Flag.croatia ? 'dictionaryCroatianString'.tr() : 'dictionaryEnglishString'.tr();
      final sortedTeams = List<Team>.from(normalGameStats.teams)..sort((a, b) => b.points.compareTo(a.points));

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
                    itemCount: sortedTeams.length,
                    itemBuilder: (_, index) {
                      final team = sortedTeams[index];

                      return StatsValueWidget(
                        text: team.name,
                        value: team.points,
                        bigText: true,
                        yellowCircle: index == 0,
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
                    icon: normalGameStats.language == Flag.croatia ? ModerniAliasIcons.croatiaImageColor : ModerniAliasIcons.unitedKingdomImageColor,
                    size: 58,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsLengthOfRoundTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  StatsTextIconWidget(
                    text: 'statsLengthOfRoundText'.tr(
                      namedArgs: {
                        'lengthOfRound': '${normalGameStats.lengthOfRound}',
                      },
                    ),
                    icon: ModerniAliasIcons.hourglassImage,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsPointsToWinTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  StatsTextIconWidget(
                    text: 'statsPointsToWinText'.tr(
                      namedArgs: {
                        'pointsToWin': '${normalGameStats.pointsToWin}',
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
                    itemCount: normalGameStats.rounds.length,
                    itemBuilder: (_, index) {
                      final round = normalGameStats.rounds[index];
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

    /// `NormalGameStats` failed to load, show error screen
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
