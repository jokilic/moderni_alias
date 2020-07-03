import 'package:flutter/material.dart';

class HorizontalScroll extends StatelessWidget {
  final List<Widget> widgets;

  HorizontalScroll(this.widgets);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
    );
  }
}
