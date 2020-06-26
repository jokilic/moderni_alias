import 'package:flutter/material.dart';

class GeneralInfo extends StatelessWidget {
  static const routeName = '/general-info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'General info screen',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
