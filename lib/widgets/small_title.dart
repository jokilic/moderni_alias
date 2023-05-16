import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class SmallTitle extends StatelessWidget {
  final String title;

  const SmallTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Text(
          title,
          style: ModerniAliasTextStyles.smallTitle,
        ),
      );
}
