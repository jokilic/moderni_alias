import 'package:flutter/material.dart';

import '../../../colors.dart';

class InfoSection extends StatelessWidget {
  final Function exitGame;
  final int correctAnswers;
  final int wrongAnswers;

  InfoSection({
    this.exitGame,
    this.correctAnswers,
    this.wrongAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 24.0),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -6,
            top: -10,
            child: FlatButton(
              child: Icon(
                Icons.close,
                color: textColor,
                size: 30.0,
              ),
              onPressed: exitGame,
            ),
          ),
          Positioned(
            right: 12,
            top: -10,
            child: Row(
              children: <Widget>[
                Text(
                  wrongAnswers.toString(),
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: textColor,
                      ),
                ),
                SizedBox(width: 10.0),
                Text(
                  correctAnswers.toString(),
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: yellowColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
