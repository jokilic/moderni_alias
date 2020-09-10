import 'package:flutter/material.dart';

import '../../components/background_image.dart';
import './components/info_button.dart';
import '../../components/hero_title.dart';
import './components/home_page_buttons.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  InfoButton(),
                  HeroTitle(),
                ],
              ),
              HomePageButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
