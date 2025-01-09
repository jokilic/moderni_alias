import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'logger_service.dart';

class PathProviderService {
  final LoggerService logger;

  PathProviderService({
    required this.logger,
  });

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
