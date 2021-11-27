import 'package:flutter/material.dart';

class HighscoreValue extends StatelessWidget {
  final String? teamName;
  final int? points;

  HighscoreValue({
    required this.teamName,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width * 0.5,
              child: Text(
                teamName ?? '',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              width: size.width * 0.1,
              child: Text(
                points.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
