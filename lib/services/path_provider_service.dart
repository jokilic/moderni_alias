import '../util/path.dart';
import 'logger_service.dart';

class PathProviderService {
  final LoggerService logger;

  PathProviderService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final String? persistenceDirectory;

  ///
  /// INIT
  ///

  Future<void> init() async {
    final appDirectory = await getPersistenceDirectory();
    persistenceDirectory = appDirectory?.path;
  }
}
