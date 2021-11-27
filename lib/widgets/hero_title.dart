import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/strings.dart';

class HeroTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 32),
              child: SvgPicture.asset(
                conversationUpImage,
                width: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: appNameFirstString,
                  style: Theme.of(context).textTheme.headline1,
                  children: const [
                    TextSpan(
                      text: appNameSecondString,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(right: 32),
              child: SvgPicture.asset(
                conversationDownImage,
                width: 70,
              ),
            ),
          ],
        ),
      );
}
