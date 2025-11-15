import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../dictionary/croatian/adjectives.dart';
import '../../dictionary/croatian/nouns.dart';
import '../../dictionary/croatian/verbs.dart';
import '../../dictionary/english/adjectives.dart';
import '../../dictionary/english/nouns.dart';
import '../../dictionary/english/verbs.dart';
import '../../util/routing.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/animated_gesture_detector.dart';
import '../../widgets/background_image.dart';
import '../../widgets/checkbox_tile_widget.dart';
import '../../widgets/game_title.dart';
import '../../widgets/hero_title.dart';

class SettingsWordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        const BackgroundImage(),
        SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimatedColumn(
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
                            ModerniAliasIcons.arrowStats,
                            color: ModerniAliasColors.white,
                            height: 26,
                            width: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  HeroTitle(
                    smallText: 'settingsWordsTitle'.tr(),
                  ),
                  const SizedBox(height: 24),

                  GameTitle(
                    'settingsWordsCroatian'.tr(),
                  ),
                  const SizedBox(height: 10),
                  CheckboxTileWidget(
                    onPressed: () => openWordsList(
                      context,
                      words: imenice,
                      title: 'wordsListTitleCroatianNouns'.tr(),
                    ),
                    title: 'settingsWordsNouns'.tr(),
                    subtitle: 'settingsWordsCroatianNouns'.tr(),
                  ),
                  const SizedBox(height: 16),
                  CheckboxTileWidget(
                    onPressed: () => openWordsList(
                      context,
                      words: glagoli,
                      title: 'wordsListTitleCroatianVerbs'.tr(),
                    ),
                    title: 'settingsWordsVerbs'.tr(),
                    subtitle: 'settingsWordsCroatianVerbs'.tr(),
                  ),
                  const SizedBox(height: 16),
                  CheckboxTileWidget(
                    onPressed: () => openWordsList(
                      context,
                      words: pridjevi,
                      title: 'wordsListTitleCroatianAdjectives'.tr(),
                    ),
                    title: 'settingsWordsAdjectives'.tr(),
                    subtitle: 'settingsWordsCroatianAdjectives'.tr(),
                  ),

                  const SizedBox(height: 12),

                  GameTitle(
                    'settingsWordsEnglish'.tr(),
                  ),
                  const SizedBox(height: 10),
                  CheckboxTileWidget(
                    onPressed: () => openWordsList(
                      context,
                      words: nouns,
                      title: 'wordsListTitleEnglishNouns'.tr(),
                    ),
                    title: 'settingsWordsNouns'.tr(),
                    subtitle: 'settingsWordsEnglishNouns'.tr(),
                  ),
                  const SizedBox(height: 16),
                  CheckboxTileWidget(
                    onPressed: () => openWordsList(
                      context,
                      words: verbs,
                      title: 'wordsListTitleEnglishVerbs'.tr(),
                    ),
                    title: 'settingsWordsVerbs'.tr(),
                    subtitle: 'settingsWordsEnglishVerbs'.tr(),
                  ),
                  const SizedBox(height: 16),
                  CheckboxTileWidget(
                    onPressed: () => openWordsList(
                      context,
                      words: adjectives,
                      title: 'wordsListTitleEnglishAdjectives'.tr(),
                    ),
                    title: 'settingsWordsAdjectives'.tr(),
                    subtitle: 'settingsWordsEnglishAdjectives'.tr(),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
