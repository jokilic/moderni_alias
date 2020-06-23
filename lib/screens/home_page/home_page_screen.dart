import 'package:flutter/material.dart';

import '../../components/background_image.dart';
import './components/home_title.dart';
import '../../components/play_button.dart';
import './components/how_to_play_button.dart';
import '../start_game/start_game_screen.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              HomeTitle(),
              SizedBox(
                height: 25.0,
              ),
              Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      PlayButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          StartGame.routeName,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      HowToPlayButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
