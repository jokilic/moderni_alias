import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './widgets/home_page_buttons.dart';
import './widgets/info_button.dart';
import '../../widgets/animated_column.dart';
import '../../widgets/background_image.dart';
import '../../widgets/hero_title.dart';

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
                      padding: EdgeInsets.all(16.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // StatsButton(),
                          SizedBox(width: 8.w),
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
