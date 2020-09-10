import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../strings.dart';

class HeroTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 32.0),
            child: SvgPicture.asset(
              conversationUpImage,
              width: 70.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: appNameFirstString,
                style: Theme.of(context).textTheme.headline1,
                children: <TextSpan>[
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
            padding: EdgeInsets.only(right: 32.0),
            child: SvgPicture.asset(
              conversationDownImage,
              width: 70.0,
            ),
          ),
        ],
      ),
    );
  }
}
