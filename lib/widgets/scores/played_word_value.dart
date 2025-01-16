import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../../constants/enums.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';

class PlayedWordValue extends StatelessWidget {
  final String word;
  final Answer chosenAnswer;

  const PlayedWordValue({
    required this.word,
    required this.chosenAnswer,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              word,
              style: ModerniAliasTextStyles.highscore,
            ),
          ),
          const SizedBox(width: 16),
          SvgPicture.asset(
            chosenAnswer == Answer.correct ? ModerniAliasIcons.correctImage : ModerniAliasIcons.wrongImage,
            colorFilter: const ColorFilter.mode(
              ModerniAliasColors.white,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
        ],
      );
}
