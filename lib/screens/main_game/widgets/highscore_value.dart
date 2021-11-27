import 'package:flutter/material.dart';

class HighscoreValue extends StatelessWidget {
  final String? teamName;
  final int? points;

  const HighscoreValue({
    required this.teamName,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.5,
              child: Text(
                teamName ?? '',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
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
