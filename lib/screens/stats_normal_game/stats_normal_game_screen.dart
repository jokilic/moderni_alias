import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/round/round.dart';
import '../../models/team/team.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';
import '../stats/widgets/stats_words_expansion_widget.dart';

class StatsNormalGameScreen extends StatelessWidget {
  final NormalGameStats normalGameStats;

  const StatsNormalGameScreen({
    required this.normalGameStats,
  });

  /// Shares `JSON` with game information
  void shareGame() => Share.shareXFiles(
        [
          XFile.fromData(
            utf8.encode(
              const JsonEncoder.withIndent('  ').convert(
                normalGameStats.toMap(),
              ),
            ),
            mimeType: 'application/json',
          ),
        ],
        fileNameOverrides: [
          'moderni_alias_normal_game_${normalGameStats.startTime.millisecondsSinceEpoch}.json',
        ],
      );

  /// Shares `audio` of selected round
  void shareRoundAudio({required Round round}) {
    if (round.audioRecording != null) {
      final name = 'moderni_alias_normal_game_${normalGameStats.startTime.millisecondsSinceEpoch}_audio_${normalGameStats.rounds.indexOf(round) + 1}.m4a';

      Share.shareXFiles(
        [XFile(round.audioRecording!, name: name)],
        fileNameOverrides: [name],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;

    final date = DateFormat('d. MMMM', locale).format(normalGameStats.startTime);
    final time = DateFormat('HH:mm', locale).format(normalGameStats.startTime);
    final textTime = timeago.format(normalGameStats.startTime, locale: locale);
    final language = normalGameStats.language == Flag.croatia ? 'dictionaryCroatianString'.tr() : 'dictionaryEnglishString'.tr();
    final sortedTeams = List<Team>.from(normalGameStats.teams)..sort((a, b) => b.points.compareTo(a.points));

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedGestureDetector(
                          onTap: Navigator.of(context).pop,
                          end: 0.8,
                          child: IconButton(
                            onPressed: null,
                            icon: Transform.rotate(
                              angle: pi,
                              child: Image.asset(
                                ModerniAliasIcons.arrowStatsImage,
                                color: ModerniAliasColors.white,
                                height: 26,
                                width: 26,
                              ),
                            ),
                          ),
                        ),
                        AnimatedGestureDetector(
                          onTap: shareGame,
                          end: 0.8,
                          child: IconButton(
                            onPressed: null,
                            icon: Image.asset(
                              ModerniAliasIcons.share,
                              color: ModerniAliasColors.white,
                              height: 26,
                              width: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
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
                        onSharePressed: () => shareRoundAudio(
                          round: round,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
