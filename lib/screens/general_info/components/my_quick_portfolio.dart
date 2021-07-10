import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../colors.dart';
import '../../../strings.dart';
import '../../../components/play_button.dart';

final AudioCache boomBabyPlayer = AudioCache();

class MyQuickPortfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: GestureDetector(
              onLongPress: () => boomBabyPlayer.play('boom.wav'),
              child: CircleAvatar(
                backgroundColor: whiteColor,
                radius: 85.0,
                child: CircleAvatar(
                  backgroundImage: AssetImage(josipImage),
                  radius: 82.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: PlayButton(
              text: aboutMeWebsiteString.toUpperCase(),
              horizontalPadding: 16.0,
              onPressed: () => launch(josipKilicWebsite),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: PlayButton(
                  text: aboutMeGitHubString.toUpperCase(),
                  horizontalPadding: 16.0,
                  onPressed: () => launch(josipGithubWebsite),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: PlayButton(
                  text: aboutMeEmailString.toUpperCase(),
                  horizontalPadding: 16.0,
                  onPressed: () => launch(josipKilicEmail),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
