import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../models/played_word/played_word.dart';
import '../../models/team/team.dart';
import '../../services/background_image_service.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/scores/show_scores.dart';

class NormalGameFinishedScreen extends WatchingWidget {
  final List<Team> teams;
  final List<PlayedWord> playedWords;

  const NormalGameFinishedScreen({
    required this.teams,
    required this.playedWords,
    required super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundImage = watchIt<BackgroundImageService>().value;

    final winningTeam = teams.reduce((a, b) => a.points > b.points ? a : b);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => disposeAndGoHome(context),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            Stack(
              children: [
                const Confetti(),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationX(pi),
                  child: const Confetti(
                    waitDuration: ModerniAliasDurations.slowAnimation,
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: const Confetti(
                    waitDuration: ModerniAliasDurations.verySlowAnimation,
                  ),
                ),
                Align(
                  child: GestureDetector(
                    onTap: () => disposeAndGoHome(context),
                    behavior: HitTestBehavior.translucent,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      height: 500,
                      child: AnimatedColumn(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ModerniAliasIcons.clapImage,
                            height: 220,
                          ),
                          const SizedBox(height: 30),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'winnerFirstString'.tr(),
                              style: ModerniAliasTextStyles.winnerFirst,
                              children: [
                                TextSpan(
                                  text: winningTeam.name,
                                  style: ModerniAliasTextStyles.winnerTeam,
                                ),
                                TextSpan(text: 'winnerSecondString'.tr()),
                                TextSpan(
                                  text: '${winningTeam.points}',
                                  style: ModerniAliasTextStyles.winnerPoints,
                                ),
                                TextSpan(text: 'winnerThirdString'.tr()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.paddingOf(context).top,
                  right: 16,
                  child: AnimatedGestureDetector(
                    onTap: () => showScores(
                      context,
                      teams: teams,
                      playedWords: playedWords,
                      backgroundImage: backgroundImage,
                    ),
                    end: 0.8,
                    child: IconButton(
                      onPressed: null,
                      icon: Image.asset(
                        ModerniAliasIcons.listImage,
                        color: ModerniAliasColors.white,
                        height: 28,
                        width: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
