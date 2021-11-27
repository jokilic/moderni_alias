import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../strings.dart';
import '../playing_game_screen.dart';

class PlayingTeamInfo extends StatelessWidget {
  final Function() showScores;
  final Function() exitGame;

  const PlayingTeamInfo({
    required this.showScores,
    required this.exitGame,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 24),
        child: Stack(
          children: [
            Align(
              child: Column(
                children: <Widget>[
                  Text(
                    currentlyPlayingPlaceholder.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    currentlyPlayingTeam.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
            Positioned(
              left: -10,
              top: -10,
              child: FlatButton(
                onPressed: exitGame,
                child: const Icon(
                  Icons.close,
                  color: whiteColor,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              right: -10,
              top: -10,
              child: FlatButton(
                onPressed: showScores,
                child: const Icon(
                  Icons.format_list_numbered,
                  color: whiteColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      );
}
