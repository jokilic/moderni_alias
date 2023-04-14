import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../localization.dart';
import '../../models/quick_game_stats/quick_game_stats.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../normal_game/widgets/played_word_value.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';

class QuickGameStatsScreen extends StatelessWidget {
  static const routeName = '/quick-game-stats-screen';

  @override
  Widget build(BuildContext context) {
    final quickGame = Get.arguments as QuickGameStats;

    final date = DateFormat('d. MMMM', Localization.locale?.languageCode ?? 'en').format(quickGame.startTime);
    final time = DateFormat('HH:mm', Localization.locale?.languageCode ?? 'en').format(quickGame.startTime);
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
                SizedBox(height: 32.h),
                const HeroTitle(),
                SizedBox(height: 24.h),
                GameTitle(
                  'statsWhenTitle'.tr,
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsTextIconWidget(
                  text: 'statsWhenText'.trParams({
                    'date': date,
                    'time': time,
                    'textTime': textTime,
                  }),
                  icon: ModerniAliasImages.clockImage,
                ),
                SizedBox(height: 16.h),
                GameTitle(
                  'statsLanguageTitle'.tr,
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsTextIconWidget(
                  text: 'statsLanguageText'.trParams({
                    'language': language,
                  }),
                  icon: quickGame.language == Flag.croatia ? ModerniAliasImages.croatiaImageColor : ModerniAliasImages.unitedKingdomImageColor,
                  size: 58,
                ),
                SizedBox(height: 16.h),
                GameTitle(
                  'statsLengthOfRoundTitle'.tr,
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsTextIconWidget(
                  text: 'statsLengthOfRoundQuickText'.tr,
                  icon: ModerniAliasImages.hourglassImage,
                ),
                SizedBox(height: 16.h),
                GameTitle(
                  'statsPointsToWinQuickTitle'.tr,
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsValueWidget(
                  text: 'statsCorrectQuick'.tr,
                  value: quickGame.round.playedWords.where((playedWord) => playedWord.chosenAnswer == Answer.correct).length,
                  bigText: true,
                ),
                SizedBox(height: 8.h),
                StatsValueWidget(
                  text: 'statsWrongQuick'.tr,
                  value: quickGame.round.playedWords.where((playedWord) => playedWord.chosenAnswer == Answer.wrong).length,
                  bigText: true,
                ),
                SizedBox(height: 16.h),
                GameTitle(
                  'statsWordsTitle'.tr,
                  smallTitle: true,
                ),
                SizedBox(height: 16.h),
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
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
