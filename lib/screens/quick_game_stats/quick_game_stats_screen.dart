// ignore_for_file: cast_nullable_to_non_nullable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../normal_game/widgets/played_word_value.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';

class QuickGameStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quickGame = ModalRoute.of(context)?.settings.arguments as QuickGameStats;

    final date = DateFormat('d. MMMM', context.locale.languageCode).format(quickGame.startTime);
    final time = DateFormat('HH:mm', context.locale.languageCode).format(quickGame.startTime);
    final textTime = timeago.format(quickGame.startTime);
    final language = quickGame.language == Flag.croatia ? 'Croatian' : 'English';

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
                  icon: quickGame.language == Flag.croatia ? ModerniAliasImages.croatiaImageColor : ModerniAliasImages.unitedKingdomImageColor,
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
                  icon: ModerniAliasImages.hourglassImage,
                ),
                const SizedBox(height: 16),
                GameTitle(
                  'statsPointsToWinQuickTitle'.tr(),
                  smallTitle: true,
                ),
                const SizedBox(height: 8),
                StatsValueWidget(
                  text: 'statsCorrectQuick'.tr(),
                  value: quickGame.round.playedWords.where((playedWord) => playedWord.chosenAnswer == Answer.correct).length,
                  bigText: true,
                ),
                const SizedBox(height: 8),
                StatsValueWidget(
                  text: 'statsWrongQuick'.tr(),
                  value: quickGame.round.playedWords.where((playedWord) => playedWord.chosenAnswer == Answer.wrong).length,
                  bigText: true,
                ),
                const SizedBox(height: 16),
                GameTitle(
                  'statsWordsTitle'.tr(),
                  smallTitle: true,
                ),
                const SizedBox(height: 16),
                ...List.generate(
                  quickGame.round.playedWords.length,
                  (index) {
                    final playedWord = quickGame.round.playedWords[index];

                    return PlayedWordValue(
                      word: playedWord.word,
                      chosenAnswer: playedWord.chosenAnswer,
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
