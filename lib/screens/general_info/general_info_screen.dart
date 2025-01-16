import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/sounds.dart';
import '../../constants/text_styles.dart';
import '../../constants/websites.dart';
import '../../services/package_info_service.dart';
import '../../util/dependencies.dart';
import '../../util/sound.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';
import '../../widgets/small_title.dart';
import '../../widgets/standard_text.dart';
import './widgets/my_quick_portfolio.dart';

class GeneralInfoScreen extends StatefulWidget {
  const GeneralInfoScreen({required super.key});

  @override
  State<GeneralInfoScreen> createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  late final AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer()
      ..setAsset(
        ModerniAliasSounds.welcomeToModerniAlias,
        preload: false,
      );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: AnimatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: AnimatedGestureDetector(
                          onTap: Navigator.of(context).pop,
                          end: 0.8,
                          child: IconButton(
                            onPressed: null,
                            icon: Transform.rotate(
                              angle: pi,
                              child: Image.asset(
                                ModerniAliasIcons.arrowStatsImage,
                                color: ModerniAliasColors.white,
                                height: 26,
                                width: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      HeroTitle(
                        smallText: 'v${getIt.get<PackageInfoService>().appVersion}',
                      ),
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
                      MyQuickPortfolio(
                        onLongPressVideo: () => playSound(
                          audioPlayer: audioPlayer,
                        ),
                      ),
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
                      GameTitle('backgroundsTitleString'.tr()),
                      StandardText(
                        RichText(
                          text: TextSpan(
                            text: 'backgroundsFirstString'.tr(),
                            style: ModerniAliasTextStyles.generalInfo,
                            children: [
                              TextSpan(
                                text: 'backgroundsSecondString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBoldBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => launchUrl(
                                        Uri.parse(ModerniAliasWebsites.pixWallsWebsite),
                                        mode: LaunchMode.externalApplication,
                                      ),
                              ),
                              TextSpan(
                                text: 'backgroundsThirdString'.tr(),
                              ),
                              TextSpan(
                                text: 'backgroundsFourthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'backgroundsFifthString'.tr(),
                              ),
                              TextSpan(
                                text: 'backgroundsSixthString'.tr(),
                                style: ModerniAliasTextStyles.generalInfoBold,
                              ),
                              TextSpan(
                                text: 'backgroundsSeventhString'.tr(),
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
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
