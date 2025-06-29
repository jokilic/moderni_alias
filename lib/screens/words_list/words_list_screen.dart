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
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 26),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
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
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              SliverToBoxAdapter(
                child: HeroTitle(smallText: title),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
              SliverToBoxAdapter(
                child: GameTitle(
                  'wordsListNumberOfWords'.tr(
                    namedArgs: {
                      'number': '${words.length}',
                    },
                  ),
                  smallTitle: true,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 12),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.builder(
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
      ],
    ),
  );
}
