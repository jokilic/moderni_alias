import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../strings.dart';
import '../../how_to_play/how_to_play_screen.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          howToPlayButtonString,
          style: TextStyle(
            fontSize: 13.0,
            color: textColor,
          ),
        ),
      ),
      onPressed: () => Navigator.pushNamed(
        context,
        HowToPlay.routeName,
      ),
      color: Colors.black45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
