import 'package:flutter/material.dart';

class GameTitle extends StatelessWidget {
  final String title;

  const GameTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
      );
}
