import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    HeroTitle(),
                    const SizedBox(height: 40),
                    const GameTitle(howTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: howFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: howSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: howThirdString,
                            ),
                            const TextSpan(
                              text: howFourthString,
                            ),
                            TextSpan(
                              text: howFifthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(flutterWebsite),
                            ),
                            const TextSpan(
                              text: howSixthString,
                            ),
                            TextSpan(
                              text: howSeventhString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: howEightString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(moderniAliasWebsite),
                            ),
                            TextSpan(
                              text: howNinthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const GameTitle(whoTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: whoFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: whoSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: whoThirdString,
                            ),
                            TextSpan(
                              text: whoFourthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: whoFifthString,
                            ),
                            const TextSpan(
                              text: whoSixthString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyQuickPortfolio(),
                    const GameTitle(fontTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: fontFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: fontSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: fontThirdString,
                            ),
                            const TextSpan(
                              text: fontFourthString,
                            ),
                            TextSpan(
                              text: fontFifthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: fontSixthString,
                            ),
                            TextSpan(
                              text: fontSeventhString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(senIconWebsite),
                            ),
                            const TextSpan(
                              text: fontEigthString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const GameTitle(iconsTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: iconsFirstString,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    const SmallTitle(appIconTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: appIconFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: appIconSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(flaticonWebsite),
                            ),
                            const TextSpan(
                              text: appIconThirdString,
                            ),
                            TextSpan(
                              text: appIconFourthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: appIconFifthString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SmallTitle(otherIconsTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: otherIconsFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: otherIconsSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(flaticonWebsite),
                            ),
                            const TextSpan(
                              text: otherIconsThirdString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const GameTitle(soundsTitleString),
                    const SmallTitle(wrongCorrectSoundsTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: wrongCorrectSoundsFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: wrongCorrectSoundsSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(googleSoundsWebsite),
                            ),
                            const TextSpan(
                              text: wrongCorrectSoundsThirdString,
                            ),
                            TextSpan(
                              text: wrongCorrectSoundsFourthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const TextSpan(
                              text: wrongCorrectSoundsFifthString,
                            ),
                            TextSpan(
                              text: wrongCorrectSoundsSixthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const TextSpan(
                              text: wrongCorrectSoundsSeventhString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SmallTitle(countdownSoundsTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: countdownSoundsFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: countdownSoundsSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(freeSoundWebsite),
                            ),
                            const TextSpan(
                              text: countdownSoundsThirdString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const GameTitle(screenshotsTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: screenshotsFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: screenshotsSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: screenshotsThirdString,
                            ),
                            TextSpan(
                              text: screenshotsFourthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: screenshotsFifthString,
                            ),
                            TextSpan(
                              text: screenshotsSixthString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: blueColor,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () => launch(screenshotsWebsite),
                            ),
                            const TextSpan(
                              text: screenshotsSeventhString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SmallTitle(enjoyTitleString),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
