import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../models/round/round.dart';
import '../../models/time_game_stats/time_game_stats.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';
import '../stats/widgets/stats_words_expansion_widget.dart';

class StatsTimeGameScreen extends StatelessWidget {
  final TimeGameStats timeGameStats;

  const StatsTimeGameScreen({
    required this.timeGameStats,
  });

  /// Shares game
  Future<bool> shareGame() async {
    final gameInfo = '''
Teams: ${timeGameStats.teams.map((team) => team.name).toList()}!
''';

    final firstRecording = timeGameStats.rounds.first.audioRecording;
    final lastRecording = timeGameStats.rounds.last.audioRecording;

    if (firstRecording != null && lastRecording != null) {
      await Share.shareXFiles(
        [
          XFile.fromData(
            utf8.encode(gameInfo),
            mimeType: 'text/plain',
          ),
          XFile(firstRecording),
          XFile(lastRecording),
        ],
        fileNameOverrides: [
          'info.txt',
          'first.m4a',
          'last.m4a',
        ],
        text: 'My recording',
        subject: 'My little subject',
      );
    }

    return true;
  }

  /// Return `true` if the passed round's duration is the same as the fastest round
  bool calculateRoundFastest({
    required Round passedRound,
    required Round fastestRound,
  }) =>
      (passedRound.durationSeconds ?? 0) <= (fastestRound.durationSeconds ?? 0);

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;

    final date = DateFormat('d. MMMM', locale).format(timeGameStats.startTime);
    final time = DateFormat('HH:mm', locale).format(timeGameStats.startTime);
    final textTime = timeago.format(timeGameStats.startTime, locale: locale);
    final language = timeGameStats.language == Flag.croatia ? 'dictionaryCroatianString'.tr() : 'dictionaryEnglishString'.tr();
    final sortedRounds = List<Round>.from(timeGameStats.rounds)..sort((a, b) => a.durationSeconds?.compareTo(b.durationSeconds ?? 0) ?? 0);

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
                    itemCount: sortedRounds.length,
                    itemBuilder: (_, index) {
                      final round = sortedRounds[index];

                      final isFastest = calculateRoundFastest(
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
        ],
      ),
    );
  }
}
