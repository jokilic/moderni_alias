import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watch_it/watch_it.dart';

import '../../constants/colors.dart';
import '../../constants/durations.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../models/played_word/played_word.dart';
import '../../services/background_image_service.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../../widgets/exit_game.dart';
import '../../widgets/play_button.dart';
import '../../widgets/scores/show_scores.dart';

class QuickGameFinishedScreen extends WatchingWidget {
  final List<PlayedWord> playedWords;

  const QuickGameFinishedScreen({
    required this.playedWords,
    required super.key,
  });

  void restartGame(BuildContext context) {
    /// Restart providers
    /// TODO
    // ref
    //   ..invalidate(currentGameProvider)
    //   ..invalidate(playedWordsProvider)
    //   ..invalidate(counter3SecondsProvider)
    //   ..invalidate(quickGameProvider(context));

    /// Go to [QuickGameScreen]
    openQuickGame(
      context,
      lengthOfRound: 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final backgroundImage = watchIt<BackgroundImageService>().value;

    final correctAnswers = playedWords.where((word) => word.chosenAnswer == Answer.correct).toList().length.toString();
    final wrongAnswers = playedWords.where((word) => word.chosenAnswer == Answer.wrong).toList().length.toString();

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
                            text: 'quickGameFinishedFirstString'.tr(),
                            style: ModerniAliasTextStyles.quickGameFinished,
                            children: [
                              TextSpan(
                                text: correctAnswers,
                                style: ModerniAliasTextStyles.quickGameFinishedBold,
                              ),
                              TextSpan(text: 'quickGameFinishedSecondString'.tr()),
                              TextSpan(
                                text: wrongAnswers,
                                style: ModerniAliasTextStyles.quickGameFinishedBold,
                              ),
                              TextSpan(
                                text: 'quickGameFinishedThirdString'.tr(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 72),
                        AnimatedColumn(
                          children: [
                            PlayButton(
                              text: 'quickGameFinishedPlayAgainString'.tr().toUpperCase(),
                              onPressed: () => restartGame(context),
                            ),
                            const SizedBox(height: 20),
                            PlayButton(
                              text: 'quickGameFinishedExitString'.tr().toUpperCase(),
                              onPressed: () => disposeAndGoHome(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.paddingOf(context).top,
                  right: 16,
                  child: AnimatedGestureDetector(
                    onTap: () => showScores(
                      context,
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
