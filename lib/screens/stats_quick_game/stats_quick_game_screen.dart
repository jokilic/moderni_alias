import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../../widgets/scores/played_word_value.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';
import '../stats/widgets/stats_words_expansion_widget.dart';

class StatsQuickGameScreen extends StatelessWidget {
  final QuickGameStats quickGameStats;

  const StatsQuickGameScreen({
    required this.quickGameStats,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;

    final date = DateFormat('d. MMMM', locale).format(quickGameStats.startTime);
    final time = DateFormat('HH:mm', locale).format(quickGameStats.startTime);
    final textTime = timeago.format(quickGameStats.startTime, locale: locale);
    final language = quickGameStats.language == Flag.croatia ? 'dictionaryCroatianString'.tr() : 'dictionaryEnglishString'.tr();

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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimatedGestureDetector(
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
                    ),
                  ),
                  const SizedBox(height: 8),
                  const HeroTitle(),
                  const SizedBox(height: 24),
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
                    icon: quickGameStats.language == Flag.croatia ? ModerniAliasIcons.croatiaImageColor : ModerniAliasIcons.unitedKingdomImageColor,
                    size: 58,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsLengthOfRoundTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  StatsTextIconWidget(
                    text: 'statsLengthOfRoundQuickText'.tr(),
                    icon: ModerniAliasIcons.hourglassImage,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsPointsToWinQuickTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 8),
                  StatsValueWidget(
                    text: 'statsCorrectQuick'.tr(),
                    value: quickGameStats.round.playedWords.where((playedWord) => playedWord.chosenAnswer == Answer.correct).length,
                    bigText: true,
                  ),
                  const SizedBox(height: 8),
                  StatsValueWidget(
                    text: 'statsWrongQuick'.tr(),
                    value: quickGameStats.round.playedWords.where((playedWord) => playedWord.chosenAnswer == Answer.wrong).length,
                    bigText: true,
                  ),
                  const SizedBox(height: 16),
                  GameTitle(
                    'statsWordsTitle'.tr(),
                    smallTitle: true,
                  ),
                  const SizedBox(height: 16),

                  ///
                  /// WORDS
                  ///
                  if (quickGameStats.round.audioRecording == null)
                    ...List.generate(
                      quickGameStats.round.playedWords.length,
                      (index) {
                        final playedWord = quickGameStats.round.playedWords[index];

                        return PlayedWordValue(
                          word: playedWord.word,
                          chosenAnswer: playedWord.chosenAnswer,
                        );
                      },
                    )

                  ///
                  /// WORDS & AUDIO RECORDING
                  ///
                  else
                    StatsWordsExpansionWidget(
                      index: 0,
                      round: quickGameStats.round,
                      someWords: quickGameStats.round.playedWords.take(3).map((word) => word.word).join(', '),
                      onSharePressed: () {},
                      quickGameStats: true,
                    ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
