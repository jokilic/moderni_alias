import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/enums.dart';
import '../../../constants/icons.dart';
import '../../../constants/text_styles.dart';
import '../../../widgets/flag_button.dart';

class SettingsLanguage extends StatelessWidget {
  final Function(Flag flag) onPressed;
  final String title;
  final String subtitle;

  const SettingsLanguage({
    required this.onPressed,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ModerniAliasTextStyles.settingsTitle,
        ),
        Text(
          subtitle,
          style: ModerniAliasTextStyles.settingsSubtitle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            createFlagButton(
              countryName: 'dictionaryCroatianString'.tr(),
              flagImage: ModerniAliasIcons.croatia,
              selectedCountry: Flag.croatia,
              onTap: () => onPressed(Flag.croatia),
              isActive: context.locale == const Locale('hr'),
            ),
            createFlagButton(
              countryName: 'dictionaryEnglishString'.tr(),
              flagImage: ModerniAliasIcons.unitedKingdom,
              selectedCountry: Flag.unitedKingdom,
              onTap: () => onPressed(Flag.unitedKingdom),
              isActive: context.locale == const Locale('en'),
            ),
          ],
        ),
      ],
    ),
  );
}
