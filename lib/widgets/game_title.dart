import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class GameTitle extends StatelessWidget {
  final String title;
  final bool smallTitle;

  const GameTitle(
    this.title, {
    this.smallTitle = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Text(
          title,
          style: ModerniAliasTextStyles.gameTitle.copyWith(
            fontSize: smallTitle ? 30 : null,
          ),
        ),
      );
}
