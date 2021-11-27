import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../how_to_play/how_to_play_screen.dart';

class HowToPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: () => Navigator.pushNamed(
          context,
          HowToPlayScreen.routeName,
        ),
        color: Colors.black45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            howToPlayButtonString,
            style: TextStyle(
              fontSize: 13,
              color: whiteColor,
            ),
          ),
        ),
      );
}
