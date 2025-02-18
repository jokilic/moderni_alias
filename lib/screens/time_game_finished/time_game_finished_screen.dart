import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../controllers/audio_record_controller.dart';
import '../../controllers/base_game_controller.dart';
import '../../models/played_word/played_word.dart';
import '../../models/round/round.dart';
import '../../models/team/team.dart';
import '../../util/dependencies.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/exit_game/exit_game.dart';
import '../../widgets/play_button.dart';
import '../../widgets/scores/show_time_scores.dart';
import '../time_game/time_game_controller.dart';

class TimeGameFinishedScreen extends StatelessWidget {
  final List<Team> teams;
  final int numberOfWords;
  final List<Round> rounds;
  final List<PlayedWord> playedWords;

  const TimeGameFinishedScreen({
    required this.teams,
    required this.numberOfWords,
    required this.rounds,
    required this.playedWords,
  });

  List<Round> findFastestRounds(List<Round> rounds) {
    rounds.sort((a, b) => a.durationSeconds?.compareTo(b.durationSeconds ?? 0) ?? 0);
    final fastestRounds = rounds.where((round) => round.durationSeconds == (rounds.first.durationSeconds ?? 0)).toList();

    return fastestRounds;
  }

  void restartGame(BuildContext context) {
    /// Dispose controllers
    unregisterIfInitialized<AudioRecordController>();
    unregisterIfInitialized<BaseGameController>();
    unregisterIfInitialized<TimeGameController>();

    /// Go to [TeamGameScreen]
    openTimeGame(
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
      numberOfWords: numberOfWords,
    );
  }

  String getTeamNamesFastestRounds(List<Round> fastestRounds) {
    fastestRounds.sort((a, b) => a.durationSeconds?.compareTo(b.durationSeconds ?? 0) ?? 0);
    final fastestTeamNames = fastestRounds.where((round) => round.durationSeconds == fastestRounds.first.durationSeconds).map((round) => round.playingTeam?.name).toList();

    if (fastestTeamNames.length <= 1) {
      return fastestTeamNames.join(', ');
    } else {
      final lastTeamName = fastestTeamNames.removeLast();
      final joinedTeamNames = fastestTeamNames.join(', ');
      return '$joinedTeamNames ${'timeGameFinishedOneWinnerAnd'.tr()} $lastTeamName';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final fastestRounds = findFastestRounds(rounds);
    final teamNames = getTeamNamesFastestRounds(fastestRounds);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => disposeAndGoHome(context),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Stack(
                alignment: Alignment.center,
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
                              text: fastestRounds.length == 1 ? 'timeGameFinishedOneWinnerFirstString'.tr() : 'timeGameFinishedOneWinnerFirstStringPlural'.tr(),
                              style: ModerniAliasTextStyles.winnerFirst,
                              children: [
                                TextSpan(
                                  text: teamNames,
                                  style: ModerniAliasTextStyles.winnerTeam,
                                ),
                                TextSpan(
                                  text: 'timeGameFinishedOneWinnerSecondString'.tr(),
                                ),
                                TextSpan(
                                  text:
                                      '${Duration(seconds: fastestRounds.first.durationSeconds ?? 0).inMinutes.toString().padLeft(2, '0')}:${(Duration(seconds: fastestRounds.first.durationSeconds ?? 0).inSeconds % 60).toString().padLeft(2, '0')}.',
                                  style: ModerniAliasTextStyles.winnerPoints,
                                ),
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
                    top: 24,
                    right: 12,
                    child: AnimatedGestureDetector(
                      onTap: () => showTimeScores(
                        context,
                        playedWords: playedWords,
                        gameFinished: true,
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
            ),
          ],
        ),
      ),
    );
  }
}
