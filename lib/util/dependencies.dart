import 'package:get_it/get_it.dart';

import '../services/background_image_service.dart';
import '../services/dictionary_service.dart';
import '../services/hive_service.dart';
import '../services/logger_service.dart';
import '../services/package_info_service.dart';
import '../services/path_provider_service.dart';

final getIt = GetIt.instance;

/// Registers a class if it's not already initialized
/// Optionally runs a function with newly registered class
T registerIfNotInitialized<T extends Object>(
  T Function() factoryFunc, {
  String? instanceName,
  void Function(T controller)? afterRegister,
}) {
  if (!getIt.isRegistered<T>(instanceName: instanceName)) {
    getIt.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
    );

    if (afterRegister != null) {
      final instance = getIt.get<T>(instanceName: instanceName);
      afterRegister(instance);
    }
  }

  return getIt.get<T>(instanceName: instanceName);
}

void initializeServices() {
  getIt
    ..registerSingletonAsync(
      () async => LoggerService(),
    )
    ..registerSingletonAsync(
      () async {
        final pathProvider = PathProviderService(
          logger: getIt.get<LoggerService>(),
        );
        await pathProvider.init();
        return pathProvider;
      },
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async {
        final packageInfo = PackageInfoService(
          logger: getIt.get<LoggerService>(),
        );
        await packageInfo.init();
        return packageInfo;
      },
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async {
        final hive = HiveService(
          logger: getIt.get<LoggerService>(),
        );
        await hive.init();
        return hive;
      },
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async {
        final dictionary = DictionaryService(
          logger: getIt.get<LoggerService>(),
        )..init();
        return dictionary;
      },
      dependsOn: [LoggerService],
    )
    ..registerSingletonAsync(
      () async => BackgroundImageService(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
      ),
      dependsOn: [LoggerService, HiveService],
    );
}
