// ignore_for_file: cast_nullable_to_non_nullable

import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../models/team/team.dart';
import '../../util/providers.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/fade_animation.dart';
import '../normal_game/widgets/show_scores.dart';

class NormalGameFinishedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winningTeam = ModalRoute.of(context)?.settings.arguments as Team;

    return FadeAnimation(
      child: WillPopScope(
        onWillPop: () async {
          goToHomeScreen(context);
          return true;
        },
        child: Scaffold(
          body: BackgroundImage(
            child: Stack(
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
                    onTap: () => goToHomeScreen(context),
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
                  top: 48,
                  right: 12,
                  child: AnimatedGestureDetector(
                    onTap: () => showScores(
                      playedWords: ref.read(playedWordsProvider),
                      context: context,
                    ),
                    end: 0.8,
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.format_list_numbered_rounded,
                        color: ModerniAliasColors.whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
