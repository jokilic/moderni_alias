import 'package:flutter/material.dart';

class GameTitle extends StatelessWidget {
  final String title;

  GameTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24.0,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
