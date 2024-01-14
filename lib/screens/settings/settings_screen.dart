import 'package:flutter/material.dart';

import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            SafeArea(
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: AnimatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      HeroTitle(),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
