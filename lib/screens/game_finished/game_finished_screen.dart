import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../widgets/background_image.dart';
import '../../widgets/confetti.dart';
import '../home/home_screen.dart';

class GameFinishedScreen extends StatefulWidget {
  static const routeName = '/game-finished';

  @override
  _GameFinishedScreenState createState() => _GameFinishedScreenState();
}

class _GameFinishedScreenState extends State<GameFinishedScreen> {
  Future<bool> exitGame(BuildContext context) async {
    await Get.offNamedUntil(
      HomeScreen.routeName,
      (route) => false,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final routeArguments = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final winningTeam = routeArguments['winningTeam'] ?? 'nitko';
    final points = routeArguments['points'] ?? 'nula';

    return WillPopScope(
      onWillPop: () => exitGame(context),
      child: BackgroundImage(
        child: Stack(
          children: [
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
            Align(
              child: GestureDetector(
                onTap: () => Get.offNamedUntil(
                  HomeScreen.routeName,
                  (route) => false,
                ),
                child: SizedBox(
                  width: size.width * 0.8,
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        clapImage,
                        height: 220,
                      ),
                      const SizedBox(height: 30),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: winnerFirstString,
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(
                              text: winningTeam,
                              style: Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const TextSpan(text: winnerSecondString),
                            TextSpan(
                              text: points,
                              style: Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const TextSpan(
                              text: winnerThirdString,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}