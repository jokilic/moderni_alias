import 'package:flutter/material.dart';

import '../../../strings.dart';
import './highscore_value.dart';
import '../playing_game_screen.dart';

void showScores(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 36.0, bottom: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              scoresModalString,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 24.0),
            Container(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) => HighscoreValue(
                  teamName: teams[index].name,
                  points: teams[index].points,
                ),
                shrinkWrap: true,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              backgroundImage,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
      );
    },
  );
}
