import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../models/round/round.dart';
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

  /// Shares `JSON` with game information
  void shareGame() => SharePlus.instance.share(
    ShareParams(
      files: [
        XFile.fromData(
          utf8.encode(
            const JsonEncoder.withIndent('  ').convert(
              quickGameStats.toMap(),
            ),
          ),
          mimeType: 'application/json',
        ),
      ],
      fileNameOverrides: [
        'moderni_alias_quick_game_${quickGameStats.startTime.millisecondsSinceEpoch}.json',
      ],
    ),
  );

  /// Shares `audio` of selected round
  void shareRoundAudio({required Round round}) {
    if (round.audioRecording != null) {
      final name = 'moderni_alias_quick_game_${quickGameStats.startTime.millisecondsSinceEpoch}_audio.m4a';

      SharePlus.instance.share(
        ShareParams(
          files: [
            XFile(
              round.audioRecording!,
              name: name,
            ),
          ],
          fileNameOverrides: [name],
        ),
      );
    }
  }

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
                                ModerniAliasIcons.arrowStats,
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
                    icon: ModerniAliasIcons.clock,
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
                    icon: quickGameStats.language == Flag.croatia ? ModerniAliasIcons.croatiaColor : ModerniAliasIcons.unitedKingdomColor,
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
                    icon: ModerniAliasIcons.hourglass,
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
                      onSharePressed: () => shareRoundAudio(
                        round: quickGameStats.round,
                      ),
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
