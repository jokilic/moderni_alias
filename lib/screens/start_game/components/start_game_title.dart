import 'package:flutter/material.dart';

class StartGameTitle extends StatelessWidget {
  final String title;

  StartGameTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 32.0,
        left: 32.0,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
