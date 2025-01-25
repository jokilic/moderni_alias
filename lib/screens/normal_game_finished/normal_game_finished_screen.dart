import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../controllers/audio_record_controller.dart';
import '../../controllers/base_game_controller.dart';
import '../../models/played_word/played_word.dart';
import '../../models/team/team.dart';
import '../../util/dependencies.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/exit_game/exit_game.dart';
import '../../widgets/play_button.dart';
import '../../widgets/scores/show_scores.dart';
import '../normal_game/normal_game_controller.dart';

class NormalGameFinishedScreen extends WatchingWidget {
  final List<Team> teams;
  final int pointsToWin;
  final int lengthOfRound;
  final List<PlayedWord> playedWords;

  const NormalGameFinishedScreen({
    required this.teams,
    required this.pointsToWin,
    required this.lengthOfRound,
    required this.playedWords,
  });

  void restartGame(BuildContext context) {
    /// Dispose controllers
    unregisterIfInitialized<AudioRecordController>();
    unregisterIfInitialized<BaseGameController>();
    unregisterIfInitialized<NormalGameController>();

    /// Go to [NormalGameScreen]
    openNormalGame(
      context,
      teams: List.from(
        teams
            .map(
              (team) => Team(
                name: team.name,
                textEditingController: team.textEditingController,
              ),
            )
            .toList(),
      ),
      pointsToWin: pointsToWin,
      lengthOfRound: lengthOfRound,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
                ///
                /// CONFETTI
                ///
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

                ///
                /// MAIN CONTENT
                ///
                Center(
                  child: SizedBox(
                    height: size.height,
                    width: size.width * 0.8,
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
                        const SizedBox(height: 72),
                        AnimatedColumn(
                          children: [
                            PlayButton(
                              text: 'gameFinishedPlayAgainString'.tr().toUpperCase(),
                              onPressed: () => restartGame(context),
                            ),
                            const SizedBox(height: 20),
                            PlayButton(
                              text: 'gameFinishedExitString'.tr().toUpperCase(),
                              onPressed: () => disposeAndGoHome(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///
                /// SHOW SCORES
                ///
                Positioned(
                  top: 86,
                  right: 12,
                  child: AnimatedGestureDetector(
                    onTap: () => showScores(
                      context,
                      teams: teams,
                      playedWords: playedWords,
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
