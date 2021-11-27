import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import './widgets/my_quick_portfolio.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
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
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'howSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'howThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'howFourthString'.tr,
                          ),
                          TextSpan(
                            text: 'howFifthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(flutterWebsite),
                          ),
                          TextSpan(
                            text: 'howSixthString'.tr,
                          ),
                          TextSpan(
                            text: 'howSeventhString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'howEightString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(moderniAliasWebsite),
                          ),
                          TextSpan(
                            text: 'howNinthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
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
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'whoSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'whoThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'whoFourthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'whoFifthString'.tr,
                          ),
                          TextSpan(
                            text: 'whoSixthString'.tr,
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
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'fontSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'fontThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'fontFourthString'.tr,
                          ),
                          TextSpan(
                            text: 'fontFifthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'fontSixthString'.tr,
                          ),
                          TextSpan(
                            text: 'fontSeventhString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(senIconWebsite),
                          ),
                          TextSpan(
                            text: 'fontEigthString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle('iitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'iconsFirstString'.tr,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  SmallTitle('appIconTitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'appIconFirstString'.tr,
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'appIconSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(flaticonWebsite),
                          ),
                          TextSpan(
                            text: 'appIconThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'appIconFourthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'appIconFifthString'.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle('otherIitleString'.tr),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: 'otherIconsFirstString'.tr,
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'otherIconsSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(flaticonWebsite),
                          ),
                          TextSpan(
                            text: 'otherIhirdString'.tr,
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
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'wrongCorrectSoundsSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(googleSoundsWebsite),
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsFourthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsFifthString'.tr,
                          ),
                          TextSpan(
                            text: 'wrongCorrectSoundsSixthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
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
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'countdownSoundsSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(freeSoundWebsite),
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
                        style: Theme.of(context).textTheme.headline4,
                        children: [
                          TextSpan(
                            text: 'screenshotsSecondString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'screenshotsThirdString'.tr,
                          ),
                          TextSpan(
                            text: 'screenshotsFourthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: 'screenshotsFifthString'.tr,
                          ),
                          TextSpan(
                            text: 'screenshotsSixthString'.tr,
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: blueColor,
                                ),
                            recognizer: TapGestureRecognizer()..onTap = () => launch(screenshotsWebsite),
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
