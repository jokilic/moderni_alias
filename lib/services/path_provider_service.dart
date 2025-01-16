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

  late final String appplicationDocumentsDirectoryPath;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    appplicationDocumentsDirectoryPath = appDirectory.path;
  }
}
