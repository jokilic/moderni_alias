import 'package:package_info_plus/package_info_plus.dart';

import 'logger_service.dart';

class PackageInfoService {
  final LoggerService logger;

  PackageInfoService({
    required this.logger,
  });

  ///
  /// VARIABLES
  ///

  late final PackageInfo packageInfo;
  late final String appVersion;

  ///
  /// INIT
  ///

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }
}
