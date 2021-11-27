import 'package:flutter/material.dart';

class SmallTitle extends StatelessWidget {
  final String title;

  SmallTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3!.copyWith(
              fontSize: 26.0,
            ),
      ),
    );
  }
}
