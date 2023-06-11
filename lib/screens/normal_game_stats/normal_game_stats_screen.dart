// ignore_for_file: cast_nullable_to_non_nullable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/team/team.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';
import '../stats/widgets/stats_words_expansion_widget.dart';

class NormalGameStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final normalGame = ModalRoute.of(context)?.settings.arguments as NormalGameStats;

    final locale = context.locale.languageCode;

    final date = DateFormat('d. MMMM', locale).format(normalGame.startTime);
    final time = DateFormat('HH:mm', locale).format(normalGame.startTime);
    final textTime = timeago.format(normalGame.startTime, locale: locale);
    final language = normalGame.language == Flag.croatia ? 'dictionaryCroatianString'.tr() : 'dictionaryEnglishString'.tr();
    final sortedTeams = List<Team>.from(normalGame.teams)..sort((a, b) => b.points.compareTo(a.points));

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
                  icon: ModerniAliasImages.clockImage,
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
                  icon: normalGame.language == Flag.croatia ? ModerniAliasImages.croatiaImageColor : ModerniAliasImages.unitedKingdomImageColor,
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
                      'lengthOfRound': '${normalGame.lengthOfRound}',
                    },
                  ),
                  icon: ModerniAliasImages.hourglassImage,
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
                      'pointsToWin': '${normalGame.pointsToWin}',
                    },
                  ),
                  icon: ModerniAliasImages.pointsImage,
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
                  itemCount: normalGame.rounds.length,
                  itemBuilder: (_, index) {
                    final round = normalGame.rounds[index];
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
}
