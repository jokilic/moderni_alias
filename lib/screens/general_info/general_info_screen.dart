import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors.dart';
import '../../strings.dart';
import '../../components/background_image.dart';
import '../../components/hero_title.dart';
import '../../components/game_title.dart';
import '../../components/standard_text.dart';
import '../../components/small_title.dart';
import './components/my_quick_portfolio.dart';

class GeneralInfo extends StatelessWidget {
  static const routeName = '/general-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  HeroTitle(),
                  SizedBox(height: 40.0),
                  GameTitle(howTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: howFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: howSecondString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: howThirdString,
                          ),
                          TextSpan(
                            text: howFourthString,
                          ),
                          TextSpan(
                            text: howFifthString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(flutterWebsite),
                          ),
                          TextSpan(
                            text: howSixthString,
                          ),
                          TextSpan(
                            text: howSeventhString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: howEightString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(moderniAliasWebsite),
                          ),
                          TextSpan(
                            text: howNinthString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle(whoTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: whoFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: whoSecondString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: whoThirdString,
                          ),
                          TextSpan(
                            text: whoFourthString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: whoFifthString,
                          ),
                          TextSpan(
                            text: whoSixthString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MyQuickPortfolio(),
                  GameTitle(fontTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: fontFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: fontSecondString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: fontThirdString,
                          ),
                          TextSpan(
                            text: fontFourthString,
                          ),
                          TextSpan(
                            text: fontFifthString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: fontSixthString,
                          ),
                          TextSpan(
                            text: fontSeventhString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(senIconWebsite),
                          ),
                          TextSpan(
                            text: fontEigthString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle(iconsTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: iconsFirstString,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  SmallTitle(appIconTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: appIconFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: appIconSecondString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(flaticonWebsite),
                          ),
                          TextSpan(
                            text: appIconThirdString,
                          ),
                          TextSpan(
                            text: appIconFourthString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: appIconFifthString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle(otherIconsTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: otherIconsFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: otherIconsSecondString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(flaticonWebsite),
                          ),
                          TextSpan(
                            text: otherIconsThirdString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle(soundsTitleString),
                  SmallTitle(wrongCorrectSoundsTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: wrongCorrectSoundsFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: wrongCorrectSoundsSecondString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(googleSoundsWebsite),
                          ),
                          TextSpan(
                            text: wrongCorrectSoundsThirdString,
                          ),
                          TextSpan(
                            text: wrongCorrectSoundsFourthString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          TextSpan(
                            text: wrongCorrectSoundsFifthString,
                          ),
                          TextSpan(
                            text: wrongCorrectSoundsSixthString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          TextSpan(
                            text: wrongCorrectSoundsSeventhString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle(countdownSoundsTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: countdownSoundsFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: countdownSoundsSecondString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(freeSoundWebsite),
                          ),
                          TextSpan(
                            text: countdownSoundsThirdString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GameTitle(screenshotsTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: screenshotsFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: screenshotsSecondString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: screenshotsThirdString,
                          ),
                          TextSpan(
                            text: screenshotsFourthString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: screenshotsFifthString,
                          ),
                          TextSpan(
                            text: screenshotsSixthString,
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: blueColor,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launch(screenshotsWebsite),
                          ),
                          TextSpan(
                            text: screenshotsSeventhString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle(enjoyTitleString),
                  SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
