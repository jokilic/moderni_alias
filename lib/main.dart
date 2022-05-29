import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'global_binding.dart';
import 'localization.dart';
import 'routes.dart';
import 'screens/home/home_screen.dart';
import 'services/logger_service.dart';
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
        designSize: const Size(390, 844),
        builder: (_, __) => GetMaterialApp(
          title: 'appNameString'.tr,
          theme: theme,
          initialRoute: HomeScreen.routeName,
          initialBinding: GlobalBinding(),
          getPages: routes,
          locale: Localization.locale,
          fallbackLocale: Localization.fallbackLocale,
          translations: Localization(),
          defaultTransition: Transition.fadeIn,
          logWriterCallback: loggingWithLogger,
        ),
      );

  void loggingWithLogger(String text, {bool isError = false}) => isError ? Get.find<LoggerService>().logger.e(text) : Get.find<LoggerService>().logger.d(text);
}
