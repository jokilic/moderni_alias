import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/text_styles.dart';
import '../../constants/websites.dart';
import '../../services/app_info_service.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../../widgets/small_title.dart';
import '../../widgets/standard_text.dart';
import './widgets/my_quick_portfolio.dart';

class GeneralInfoScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(appInfoProvider).when(
        data: (appInfoService) => Scaffold(
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
                      HeroTitle(smallText: appInfoService.appVersion),
                      const SizedBox(height: 40),
                      GameTitle('howTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'howFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'howSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'howThirdString'.tr(),
                              ),
                              TextSpan(
                                text: 'howFourthString'.tr(),
                              ),
                              TextSpan(
                                text: 'howFifthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.flutterWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'howSixthString'.tr(),
                              ),
                              TextSpan(
                                text: 'howSeventhString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'howEightString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.moderniAliasWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'howNinthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GameTitle('whoTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'whoFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'whoSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'whoThirdString'.tr(),
                              ),
                              TextSpan(
                                text: 'whoFourthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'whoFifthString'.tr(),
                              ),
                              TextSpan(
                                text: 'whoSixthString'.tr(),
                              ),
                              TextSpan(
                                text: 'whoSeventhString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'whoEighthString'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MyQuickPortfolio(),
                      GameTitle('fontTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'fontFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'fontSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'fontThirdString'.tr(),
                              ),
                              TextSpan(
                                text: 'fontFourthString'.tr(),
                              ),
                              TextSpan(
                                text: 'fontFifthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'fontSixthString'.tr(),
                              ),
                              TextSpan(
                                text: 'fontSeventhString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.senIconWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'fontEigthString'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GameTitle('iconsTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'iconsFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                          ),
                        ),
                      ),
                      SmallTitle('appIconTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'appIconFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'appIconSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.flaticonWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'appIconThirdString'.tr(),
                              ),
                              TextSpan(
                                text: 'appIconFourthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'appIconFifthString'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SmallTitle('otherIconsTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'otherIconsFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'otherIconsSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.flaticonWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'otherIconsThirdString'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GameTitle('soundsTitleString'.tr()),
                      SmallTitle('wrongCorrectSoundsTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'wrongCorrectSoundsFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'wrongCorrectSoundsSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.googleSoundsWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'wrongCorrectSoundsThirdString'.tr(),
                              ),
                              TextSpan(
                                text: 'wrongCorrectSoundsFourthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'wrongCorrectSoundsFifthString'.tr(),
                              ),
                              TextSpan(
                                text: 'wrongCorrectSoundsSixthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'wrongCorrectSoundsSeventhString'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SmallTitle('countdownSoundsTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'countdownSoundsFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'countdownSoundsSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.freeSoundWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'countdownSoundsThirdString'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GameTitle('screenshotsTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'screenshotsFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'screenshotsSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'screenshotsThirdString'.tr(),
                              ),
                              TextSpan(
                                text: 'screenshotsFourthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'screenshotsFifthString'.tr(),
                              ),
                              TextSpan(
                                text: 'screenshotsSixthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.screenshotsWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'screenshotsSeventhString'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SmallTitle('enjoyTitleString'.tr()),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        error: (error, stackTrace) => const SizedBox.shrink(),
        loading: () => const SizedBox.shrink(),
      );
}
