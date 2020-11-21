import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../strings.dart';
import '../../components/background_image.dart';
import '../../components/hero_title.dart';
import '../../components/game_title.dart';
import '../../components/small_title.dart';
import '../../components/standard_text.dart';

class HowToPlay extends StatelessWidget {
  static const routeName = '/how-to-play';

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
                  GameTitle(whatIsAliasTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: whatIsAliasFirstString,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: whatIsAliasSecondString,
                              style: Theme.of(context).textTheme.headline4),
                          TextSpan(
                            text: whatIsAliasThirdString,
                          ),
                          TextSpan(
                              text: whatIsAliasFourthString,
                              style: Theme.of(context).textTheme.headline4),
                          TextSpan(
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
                  GameTitle(howToPlayTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: howToPlayExplanationString,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  SmallTitle(wordCorrectTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: wordCorrectExplanationFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: wordCorrectExplanationSecondString,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: greenColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          TextSpan(
                            text: wordCorrectExplanationThirdString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle(wordWrongTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: wordWrongExplanationFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: wordWrongExplanationSecondString,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: redColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          TextSpan(
                            text: wordWrongExplanationThirdString,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SmallTitle(roundFinishedTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: roundFinishedExplanationString,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  GameTitle(howToQuickAliasTitleString),
                  StandardText(
                    RichText(
                      text: TextSpan(
                        text: howToQuickAliasExplanationFirstString,
                        style: Theme.of(context).textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                            text: howToQuickAliasExplanationSecondString,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: howToQuickAliasExplanationThirdString,
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
