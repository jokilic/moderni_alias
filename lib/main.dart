import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/colors.dart';
import 'screens/home/home_screen.dart';
import 'theme.dart';
import 'util/dependencies.dart';

Future<void> main() async {
  /// Initialize Flutter related tasks
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Make sure the status bar shows white text
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );

  /// Initialize [EasyLocalization]
  await EasyLocalization.ensureInitialized();

  /// Initialize services
  initializeServices();

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Run the app, let's go!
  runApp(
    ModerniAliasApp(),
  );
}

class ModerniAliasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: const [
          Locale('en'),
          Locale('hr'),
        ],
        // startLocale: const Locale('hr'),
        fallbackLocale: const Locale('hr'),
        path: 'assets/translations',
        child: ModerniAliasWidget(),
      );
}

class ModerniAliasWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (_) => 'appNameString'.tr(),
        theme: theme,
        home: const HomeScreen(
          key: ValueKey('home'),
        ),
        builder: (context, child) {
          /// Generate `appWidget`, with [Moderni Alias] content
          final appWidget = child ??
              const Scaffold(
                body: SizedBox.shrink(),
              );

          /// Return `appWidget`, also [Banner] if app is `debug`
          return kDebugMode
              ? Banner(
                  message: 'Josip'.toUpperCase(),
                  color: ModerniAliasColors.blue,
                  location: BannerLocation.topEnd,
                  layoutDirection: TextDirection.ltr,
                  child: appWidget,
                )
              : appWidget;
        },
      );
}
