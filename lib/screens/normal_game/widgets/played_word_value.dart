import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../constants/strings.dart';
import '../../../constants/text_styles.dart';

class PlayedWordValue extends StatelessWidget {
  final String word;
  final Answer chosenAnswer;

  const PlayedWordValue({
    required this.word,
    required this.chosenAnswer,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  word,
                  style: ModerniAliasTextStyles.highscore,
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: Get.width * 0.1,
                child: SvgPicture.asset(
                  chosenAnswer == Answer.correct ? ModerniAliasImages.correctImage : ModerniAliasImages.wrongImage,
                  colorFilter: const ColorFilter.mode(
                    ModerniAliasColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      );
}
