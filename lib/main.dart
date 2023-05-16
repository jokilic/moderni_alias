import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'global_binding.dart';
import 'localization.dart';
import 'routes.dart';
import 'screens/home/home_screen.dart';
import 'services/logger_service.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Make sure the status bar shows white text
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );

  /// Run the app, let's go!
  runApp(ModerniAlias());
}

class ModerniAlias extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        onGenerateTitle: (_) => 'appNameString'.tr,
        theme: theme,
        initialRoute: HomeScreen.routeName,
        initialBinding: GlobalBinding(),
        getPages: routes,
        locale: Localization.locale,
        fallbackLocale: Localization.fallbackLocale,
        translations: Localization(),
        defaultTransition: Transition.fadeIn,
        logWriterCallback: loggingWithLogger,
      );

  void loggingWithLogger(String text, {bool isError = false}) => isError ? Get.find<LoggerService>().logger.e(text) : Get.find<LoggerService>().logger.d(text);
}
