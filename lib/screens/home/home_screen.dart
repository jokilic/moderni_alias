import 'package:flutter/material.dart';

import './widgets/home_page_buttons.dart';
import './widgets/info_button.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
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
