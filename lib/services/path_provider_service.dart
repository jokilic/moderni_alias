import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'logger_service.dart';

final pathProvider = Provider<PathProviderService>(
  (_) => throw UnimplementedError(),
  name: 'PathProvider',
);

class PathProviderService {
  ///
  /// CONSTRUCTOR
  ///

  final LoggerService logger;

  PathProviderService(this.logger) {
    init();
  }

  ///
  /// VARIABLES
  ///

  late final String appDocDirectory;

  ///
  /// INIT
  ///

  Future<void> init() async {
    appDocDirectory = await getApplicationDocumentsDirectory().then((directory) => directory.path);
  }

  /// Checks if [File] on the passed `filePath` exists
  Future<bool> doesFileExist(String filePath) async => File(filePath).exists();
}
