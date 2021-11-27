import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './screens/general_info/general_info_screen.dart';
import './screens/how_to_play/how_to_play_screen.dart';
import './screens/quick_game/quick_game_screen.dart';
import './screens/start_game/start_game_screen.dart';
import 'bindings/global_binding.dart';
import 'localization.dart';
import 'routes.dart';
import 'screens/game_finished/game_finished_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/main_game/main_game_screen.dart';
import 'screens/quick_game_finished/quick_game_finished_screen.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(ModerniAlias());
}

class ModerniAlias extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        builder: () => GetMaterialApp(
          title: 'appNameString'.tr,
          theme: theme,
          initialRoute: HomeScreen.routeName,
          initialBinding: GlobalBinding(),
          getPages: routes,
          locale: Localization.locale,
          fallbackLocale: Localization.fallbackLocale,
          translations: Localization(),
          defaultTransition: Transition.fadeIn,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            GeneralInfoScreen.routeName: (context) => GeneralInfoScreen(),
            StartGameScreen.routeName: (context) => StartGameScreen(),
            HowToPlayScreen.routeName: (context) => HowToPlayScreen(),
            MainGameScreen.routeName: (context) => MainGameScreen(),
            GameFinishedScreen.routeName: (context) => GameFinishedScreen(),
            QuickGameScreen.routeName: (context) => QuickGameScreen(),
            QuickGameFinishedScreen.routeName: (context) => QuickGameFinishedScreen(),
          },
        ),
      );
}
