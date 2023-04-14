// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/enums.dart';
import '../../constants/strings.dart';
import '../../localization.dart';
import '../../models/normal_game_stats/normal_game_stats.dart';
import '../../models/team/team.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../stats/widgets/stats_text_icon_widget.dart';
import '../stats/widgets/stats_value_widget.dart';
import '../stats/widgets/stats_words_expansion_widget.dart';

class NormalGameStatsScreen extends StatelessWidget {
  static const routeName = '/normal-game-stats-screen';

  @override
  Widget build(BuildContext context) {
    final normalGame = Get.arguments as NormalGameStats;

    final date = DateFormat('d. MMMM', Localization.locale?.languageCode ?? 'en').format(normalGame.startTime);
    final time = DateFormat('HH:mm', Localization.locale?.languageCode ?? 'en').format(normalGame.startTime);
    final textTime = timeago.format(normalGame.startTime);
    final language = normalGame.language == Flag.croatia ? 'Croatian' : 'English';
    final sortedTeams = List<Team>.from(normalGame.teams)..sort((a, b) => b.points.compareTo(a.points));

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
                const GameTitle(
                  'Who won?',
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: normalGame.teams.length,
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
                SizedBox(height: 16.h),
                const GameTitle(
                  'When?',
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsTextIconWidget(
                  text: 'The game started $date at $time.\nThis was $textTime.',
                  icon: ModerniAliasImages.clockImage,
                ),
                SizedBox(height: 16.h),
                const GameTitle(
                  'Language?',
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsTextIconWidget(
                  text: '$language was the language played.',
                  icon: normalGame.language == Flag.croatia ? ModerniAliasImages.croatiaImageColor : ModerniAliasImages.unitedKingdomImageColor,
                  size: 58,
                ),
                SizedBox(height: 16.h),
                const GameTitle(
                  'Length of round?',
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsTextIconWidget(
                  text: 'Round took ${normalGame.lengthOfRound} seconds.',
                  icon: ModerniAliasImages.hourglassImage,
                ),
                SizedBox(height: 16.h),
                const GameTitle(
                  'Points to win?',
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                StatsTextIconWidget(
                  text: 'Players had to guess ${normalGame.pointsToWin} points to win.',
                  icon: ModerniAliasImages.pointsImage,
                ),
                SizedBox(height: 16.h),
                const GameTitle(
                  'And the words?',
                  smallTitle: true,
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
