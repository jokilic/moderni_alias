import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/background_image.dart';
import '../../components/confetti.dart';
import '../../components/play_button.dart';
import '../../strings.dart';
import '../home_page/home_page_screen.dart';
import '../quick_game/quick_game_screen.dart';

class QuickGameFinished extends StatefulWidget {
  static const routeName = '/quick-game-finished';

  @override
  _QuickGameFinishedState createState() => _QuickGameFinishedState();
}

class _QuickGameFinishedState extends State<QuickGameFinished> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final routeArguments = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final correctAnswers = routeArguments['correctAnswers'] ?? '0';
    final wrongAnswers = routeArguments['wrongAnswers'] ?? '0';

    Future<bool> exitGame(BuildContext context) async {
      Navigator.popUntil(
        context,
        ModalRoute.withName(HomePage.routeName),
      );
      return true;
    }

    return WillPopScope(
      onWillPop: () => exitGame(context),
      child: BackgroundImage(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 200,
              left: size.width / 2,
              child: Confetti(),
            ),
            Positioned(
              bottom: 200,
              left: size.width / 2,
              child: Confetti(),
            ),
            Positioned(
              top: size.height / 2,
              left: 50,
              child: Confetti(),
            ),
            Positioned(
              top: size.height / 2,
              right: 50,
              child: Confetti(),
            ),
            Center(
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      clapImage,
                      height: 220,
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: quickGameFinishedFirstString,
                        style: Theme.of(context).textTheme.bodyText1,
                        children: <TextSpan>[
                          TextSpan(
                            text: correctAnswers,
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const TextSpan(text: quickGameFinishedSecondString),
                          TextSpan(
                            text: wrongAnswers,
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const TextSpan(
                            text: quickGameFinishedThirdString,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Column(
                      children: <Widget>[
                        PlayButton(
                          text: quickGameFinishedPlayAgainString.toUpperCase(),
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            QuickGame.routeName,
                          ),
                        ),
                        const SizedBox(height: 20),
                        PlayButton(
                          text: quickGameFinishedExitString.toUpperCase(),
                          onPressed: () => Navigator.popUntil(
                            context,
                            ModalRoute.withName(HomePage.routeName),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
