import 'package:flutter/material.dart';

import '../../../strings.dart';
import '../../../components/play_button.dart';
import './how_to_play_button.dart';
import '../../start_game/start_game_screen.dart';
import '../../quick_game/quick_game_screen.dart';

class HomePageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                PlayButton(
                  text: startButtonString.toUpperCase(),
                  horizontalPadding: 44.0,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    StartGame.routeName,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                PlayButton(
                  text: quickStartButtonString.toUpperCase(),
                  horizontalPadding: 50.0,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    QuickGame.routeName,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                HowToPlayButton(),
              ],
            )),
      ),
    );
  }
}
