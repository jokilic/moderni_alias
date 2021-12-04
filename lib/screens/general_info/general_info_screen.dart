import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import './widgets/my_quick_portfolio.dart';
import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../../widgets/small_title.dart';
import '../../widgets/standard_text.dart';

class GeneralInfoScreen extends StatelessWidget {
  static const routeName = '/general-info';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 50.h),
                  HeroTitle(),
                  SizedBox(height: 40.h),
                  GameTitle('howTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'howFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'howSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'howThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'howFourthString'.tr,
                          ),
                          TextSpan(
                            text: 'howFifthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.flutterWebsite),
                          ),
                          TextSpan(
                            text: 'howSixthString'.tr,
                          ),
                          TextSpan(
                            text: 'howSeventhString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'howEightString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.moderniAliasWebsite),
                          ),
                          TextSpan(
                            text: 'howNinthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle('whoTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'whoFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'whoSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'whoThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'whoFourthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'whoFifthString'.tr,
                          ),
                          TextSpan(
                            text: 'whoSixthString'.tr,
                          ),
                          TextSpan(
                            text: 'whoSeventhString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'whoEighthString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MyQuickPortfolio(),
                  GameTitle('fontTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'fontFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'fontSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'fontThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'fontFourthString'.tr,
                          ),
                          TextSpan(
                            text: 'fontFifthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'fontSixthString'.tr,
                          ),
                          TextSpan(
                            text: 'fontSeventhString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.senIconWebsite),
                          ),
                          TextSpan(
                            text: 'fontEigthString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle('iconsTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'iconsFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                      ),
                    ),
                  ),
                  SmallTitle('appIconTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'appIconFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'appIconSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.flaticonWebsite),
                          ),
                          TextSpan(
                            text: 'appIconThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'appIconFourthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'appIconFifthString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle('otherIconsTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'otherIconsFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'otherIconsSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.flaticonWebsite),
                          ),
                          TextSpan(
                            text: 'otherIconsThirdString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle('soundsTitleString'.tr),
                  SmallTitle('wrongCorrectSoundsTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'wrongCorrectSoundsFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'wrongCorrectSoundsSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.googleSoundsWebsite),
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsFourthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsFifthString'.tr,
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsSixthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsSeventhString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle('countdownSoundsTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'countdownSoundsFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'countdownSoundsSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.freeSoundWebsite),
                          ),
                          TextSpan(
                            text: 'countdownSoundsThirdString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle('screenshotsTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'screenshotsFirstString'.tr,
                        style: ModerniAliasTextStyles.generalInfo,
                        children: [
                          TextSpan(
                            text: 'screenshotsSecondString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'screenshotsThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'screenshotsFourthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBold,
                          ),
                          TextSpan(
                            text: 'screenshotsFifthString'.tr,
                          ),
                          TextSpan(
                            text: 'screenshotsSixthString'.tr,
                            style: ModerniAliasTextStyles.generalInfoBoldBlue,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(ModerniAliasWebsites.screenshotsWebsite),
                          ),
                          TextSpan(
                            text: 'screenshotsSeventhString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle('enjoyTitleString'.tr),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      );
}
