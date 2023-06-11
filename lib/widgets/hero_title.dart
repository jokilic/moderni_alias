import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/icons.dart';
import '../constants/text_styles.dart';
import 'animated_column.dart';

class HeroTitle extends StatelessWidget {
  final String? smallText;

  const HeroTitle({
    this.smallText,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: AnimatedColumn(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 32),
              child: SvgPicture.asset(
                ModerniAliasIcons.conversationUpImage,
                width: 70,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: smallText == null ? 12 : 0,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'appNameFirstString'.tr(),
                      style: ModerniAliasTextStyles.appNameFirst,
                      children: [
                        TextSpan(
                          text: 'appNameSecondString'.tr(),
                          style: ModerniAliasTextStyles.appNameSecond,
                        ),
                      ],
                    ),
                  ),
                ),
                if (smallText != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                      right: 8,
                    ),
                    child: Text(
                      smallText!,
                      style: ModerniAliasTextStyles.smallHero,
                      textAlign: TextAlign.end,
                    ),
                  ),
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: 32),
              child: SvgPicture.asset(
                ModerniAliasIcons.conversationDownImage,
                width: 70,
              ),
            ),
          ],
        ),
      );
}
