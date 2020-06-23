import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  static const routeName = '/how-to-play';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'How to play',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
