import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart';

import 'constants/translations.dart';
import 'services/hive_service.dart';
import 'services/logger_service.dart';
import 'services/path_provider_service.dart';
import 'util/routing.dart';
import 'util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Parsing of [StackTrace]
  FlutterError.demangleStackTrace = (stack) {
    if (stack is Trace) {
      return stack.vmTrace;
    }
    if (stack is Chain) {
      return stack.toTrace().vmTrace;
    }
    return stack;
  };

  /// Initialize [EasyLocalization]
  await EasyLocalization.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Make sure the status bar shows white text
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );

  /// Initialize [Logger], [Path] & [Hive]
  final logger = LoggerService();
  final path = PathProviderService(logger);
  final hive = HiveService(logger);
  await hive.init();

  /// Run the app, let's go!
  runApp(
    ProviderScope(
      overrides: [
        loggerProvider.overrideWithValue(logger),
        pathProvider.overrideWithValue(path),
        hiveProvider.overrideWithValue(hive),
      ],
      observers: [
        RiverpodLogger(logger),
      ],
      child: ModerniAlias(),
    ),
  );
}

class ModerniAlias extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: const [Locale('hr'), Locale('en')],
        path: ModerniAliasTranslations.folderLocation,
        fallbackLocale: const Locale('hr'),
        child: Builder(
          builder: (context) => MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateTitle: (_) => 'appNameString'.tr(),
            onGenerateRoute: onGenerateRoute,
            initialRoute: ModerniAliasRoutes.homeScreen,
            theme: ref.watch(themeProvider),
          ),
        ),
      );
}
