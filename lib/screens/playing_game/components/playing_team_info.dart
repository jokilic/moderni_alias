import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../strings.dart';
import '../playing_game_screen.dart';

class PlayingTeamInfo extends StatelessWidget {
  final Function showScores;
  final Function exitGame;

  PlayingTeamInfo({this.showScores, this.exitGame});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
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
            left: -6,
            top: -10,
            child: FlatButton(
              child: Icon(
                Icons.close,
                color: buttonColor,
                size: 30.0,
              ),
              onPressed: exitGame,
            ),
          ),
          Positioned(
            right: -6,
            top: -10,
            child: FlatButton(
              child: Icon(
                Icons.format_list_numbered,
                color: buttonColor,
                size: 30.0,
              ),
              onPressed: showScores,
            ),
          ),
        ],
      ),
    );
  }
}
