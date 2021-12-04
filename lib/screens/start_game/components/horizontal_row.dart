import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  final List<Widget> widgets;

  const HorizontalScroll(this.widgets);

  @override
  Widget build(BuildContext context) => Align(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
      );
}
