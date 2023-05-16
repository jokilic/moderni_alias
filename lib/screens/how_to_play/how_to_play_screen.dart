import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/text_styles.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../../widgets/small_title.dart';
import '../../widgets/standard_text.dart';

class HowToPlayScreen extends StatelessWidget {
  static const routeName = '/how-to-play-screen';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const HeroTitle(),
                    const SizedBox(height: 40),
                    GameTitle('whatIsAliasTitleString'.tr),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: 'whatIsAliasFirstString'.tr,
                          style: ModerniAliasTextStyles.howToPlayBold,
                          children: [
                            TextSpan(
                              text: 'whatIsAliasSecondString'.tr,
                              style: ModerniAliasTextStyles.howToPlay,
                            ),
                            TextSpan(
                              text: 'whatIsAliasThirdString'.tr,
                            ),
                            TextSpan(
                              text: 'whatIsAliasFourthString'.tr,
                              style: ModerniAliasTextStyles.howToPlay,
                            ),
                            TextSpan(
                              text: 'whatIsAliasFifthString'.tr,
                            ),
                            TextSpan(
                              text: 'whatIsAliasSixthString'.tr,
                              style: ModerniAliasTextStyles.howToPlay,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GameTitle('howToPlayTitleString'.tr),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: 'howToPlayExplanationString'.tr,
                          style: ModerniAliasTextStyles.howToPlay,
                        ),
                      ),
                    ),
                    SmallTitle('wordCorrectTitleString'.tr),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: 'wordCorrectExplanationFirstString'.tr,
                          style: ModerniAliasTextStyles.howToPlay,
                          children: [
                            TextSpan(
                              text: 'wordCorrectExplanationSecondString'.tr,
                              style: ModerniAliasTextStyles.howToPlayBoldGreen,
                            ),
                            TextSpan(
                              text: 'wordCorrectExplanationThirdString'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SmallTitle('wordWrongTitleString'.tr),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: 'wordWrongExplanationFirstString'.tr,
                          style: ModerniAliasTextStyles.howToPlay,
                          children: [
                            TextSpan(
                              text: 'wordWrongExplanationSecondString'.tr,
                              style: ModerniAliasTextStyles.howToPlayBoldRed,
                            ),
                            TextSpan(
                              text: 'wordWrongExplanationThirdString'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SmallTitle('roundFinishedTitleString'.tr),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: 'roundFinishedExplanationString'.tr,
                          style: ModerniAliasTextStyles.howToPlay,
                        ),
                      ),
                    ),
                    GameTitle('howToQuickAliasTitleString'.tr),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: 'howToQuickAliasExplanationFirstString'.tr,
                          style: ModerniAliasTextStyles.howToPlay,
                          children: [
                            TextSpan(
                              text: 'howToQuickAliasExplanationSecondString'.tr,
                              style: ModerniAliasTextStyles.howToPlayBold,
                            ),
                            TextSpan(
                              text: 'howToQuickAliasExplanationThirdString'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SmallTitle('enjoyTitleString'.tr),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
