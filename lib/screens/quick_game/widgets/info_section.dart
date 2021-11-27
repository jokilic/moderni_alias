import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class InfoSection extends StatelessWidget {
  final Function() exitGame;
  final int correctAnswers;
  final int wrongAnswers;

  const InfoSection({
    required this.exitGame,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        margin: const EdgeInsets.only(top: 24),
        child: Stack(
          children: [
            Positioned(
              left: -10,
              top: -10,
              child: FlatButton(
                onPressed: exitGame,
                child: const Icon(
                  Icons.close,
                  color: whiteColor,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -10,
              child: Row(
                children: [
                  Text(
                    wrongAnswers.toString(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: whiteColor,
                        ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    correctAnswers.toString(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: blueColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
