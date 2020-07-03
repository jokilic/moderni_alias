import 'package:flutter/material.dart';

class HighscoreValue extends StatelessWidget {
  final String teamName;
  final int points;

  HighscoreValue({this.teamName, this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 225.0,
            child: Text(
              teamName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text(
            points.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
