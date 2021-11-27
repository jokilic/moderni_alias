import 'package:flutter/material.dart';

class SmallTitle extends StatelessWidget {
  final String title;

  const SmallTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 26,
              ),
        ),
      );
}
