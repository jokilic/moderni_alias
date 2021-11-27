import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../widgets/play_button.dart';

final AudioCache boomBabyPlayer = AudioCache();

class MyQuickPortfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onLongPress: () => boomBabyPlayer.play('boom.wav'),
                child: const CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 85,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(josipImage),
                    radius: 82,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: PlayButton(
                text: aboutMeWebsiteString.toUpperCase(),
                horizontalPadding: 16,
                onPressed: () => launch(josipKilicWebsite),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlayButton(
                    text: aboutMeGitHubString.toUpperCase(),
                    horizontalPadding: 16,
                    onPressed: () => launch(josipGithubWebsite),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlayButton(
                    text: aboutMeEmailString.toUpperCase(),
                    horizontalPadding: 16,
                    onPressed: () => launch(josipKilicEmail),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
