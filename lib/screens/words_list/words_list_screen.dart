import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/text_styles.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';

class WordsListScreen extends StatelessWidget {
  final String title;
  final List<String> words;

  const WordsListScreen({
    required this.title,
    required this.words,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        const BackgroundImage(),
        SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedGestureDetector(
                    onTap: Navigator.of(context).pop,
                    end: 0.8,
                    child: IconButton(
                      onPressed: null,
                      icon: Transform.rotate(
                        angle: pi,
                        child: Image.asset(
                          ModerniAliasIcons.arrowStatsImage,
                          color: ModerniAliasColors.white,
                          height: 26,
                          width: 26,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                HeroTitle(smallText: title),
                const SizedBox(height: 32),
                GameTitle(
                  'wordsListNumberOfWords'.tr(
                    namedArgs: {
                      'number': '${words.length}',
                    },
                  ),
                  smallTitle: true,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: words.length,
                    itemBuilder: (_, index) => ListTile(
                      title: Text(
                        words[index],
                        style: ModerniAliasTextStyles.wordListTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
