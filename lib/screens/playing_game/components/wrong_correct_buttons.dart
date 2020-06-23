import 'package:flutter/material.dart';

import '../../../strings.dart';
import './game_button.dart';

class WrongCorrectButtons extends StatelessWidget {
  final Function wrongChosen;
  final Function correctChosen;

  WrongCorrectButtons({this.wrongChosen, this.correctChosen});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GameButton(
          svgIconPath: wrongImage,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
          ),
          onTap: wrongChosen,
        ),
        GameButton(
          svgIconPath: correctImage,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.0),
          ),
          onTap: correctChosen,
        ),
      ],
    );
  }
}
