import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../components/background_image.dart';
import '../../components/game_title.dart';
import '../../components/hero_title.dart';
import '../../components/small_title.dart';
import '../../components/standard_text.dart';
import '../../strings.dart';

class HowToPlay extends StatelessWidget {
  static const routeName = '/how-to-play';

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
                    const GameTitle(whatIsAliasTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: whatIsAliasFirstString,
                          style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: whatIsAliasSecondString, style: Theme.of(context).textTheme.headline4),
                            const TextSpan(
                              text: whatIsAliasThirdString,
                            ),
                            TextSpan(text: whatIsAliasFourthString, style: Theme.of(context).textTheme.headline4),
                            const TextSpan(
                              text: whatIsAliasFifthString,
                            ),
                            TextSpan(
                              text: whatIsAliasSixthString,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const GameTitle(howToPlayTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: howToPlayExplanationString,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    const SmallTitle(wordCorrectTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: wordCorrectExplanationFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: wordCorrectExplanationSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    color: greenColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const TextSpan(
                              text: wordCorrectExplanationThirdString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SmallTitle(wordWrongTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: wordWrongExplanationFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: wordWrongExplanationSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    color: redColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const TextSpan(
                              text: wordWrongExplanationThirdString,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SmallTitle(roundFinishedTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: roundFinishedExplanationString,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    const GameTitle(howToQuickAliasTitleString),
                    StandardText(
                      RichText(
                        text: TextSpan(
                          text: howToQuickAliasExplanationFirstString,
                          style: Theme.of(context).textTheme.headline4,
                          children: <TextSpan>[
                            TextSpan(
                              text: howToQuickAliasExplanationSecondString,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: howToQuickAliasExplanationThirdString,
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
