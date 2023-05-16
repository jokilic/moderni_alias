import 'package:flutter/material.dart';

import './widgets/home_page_buttons.dart';
import './widgets/info_button.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';
import 'widgets/how_to_play_button.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BackgroundImage(
          child: SafeArea(
            child: AnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedColumn(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          HowToPlayButton(),
                          const SizedBox(width: 8),
                          InfoButton(),
                        ],
                      ),
                    ),
                    const HeroTitle(),
                  ],
                ),
                HomePageButtons(),
              ],
            ),
          ),
        ),
      );
}
