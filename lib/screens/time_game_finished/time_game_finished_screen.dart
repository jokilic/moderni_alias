import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../models/round/round.dart';
import '../../util/providers.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/scores/show_time_scores.dart';
import '../time_game/time_game_controller.dart';

class TimeGameFinishedScreen extends ConsumerWidget {
  List<Round> findFastestRounds(List<Round> rounds) {
    rounds.sort((a, b) => a.durationSeconds?.compareTo(b.durationSeconds ?? 0) ?? 0);
    final fastestRounds = rounds.where((round) => round.durationSeconds == (rounds.first.durationSeconds ?? 0)).toList();

    return fastestRounds;
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
  Widget build(BuildContext context, WidgetRef ref) {
    final fastestRounds = findFastestRounds(
      ref.watch(timeGameProvider).timeGameStats.rounds,
    );
    final teamNames = getTeamNamesFastestRounds(fastestRounds);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => disposeGames(context, ref),
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
                    onTap: () => disposeGames(context, ref),
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
                              text: fastestRounds.length == 1 ? 'timeGameFinishedOneWinnerFirstString'.tr() : 'timeGameFinishedOneWinnerFirstStringPlural'.tr(),
                              style: ModerniAliasTextStyles.winnerFirst,
                              children: [
                                TextSpan(
                                  text: teamNames,
                                  style: ModerniAliasTextStyles.winnerTeam,
                                ),
                                TextSpan(text: 'timeGameFinishedOneWinnerSecondString'.tr()),
                                TextSpan(
                                  text:
                                      '${Duration(seconds: fastestRounds.first.durationSeconds ?? 0).inMinutes.toString().padLeft(2, '0')}:${(Duration(seconds: fastestRounds.first.durationSeconds ?? 0).inSeconds % 60).toString().padLeft(2, '0')}.',
                                  style: ModerniAliasTextStyles.winnerPoints,
                                ),
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
                    onTap: () => showTimeScores(
                      context,
                      playedWords: ref.watch(playedWordsProvider),
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
          ],
        ),
      ),
    );
  }
}
