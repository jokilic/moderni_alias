import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final appInfoProvider = Provider<AppInfoService>((ref) => AppInfoService());

class AppInfoService {
  ///
  /// CONSTRUCTOR
  ///

  AppInfoService() {
    init();
  }

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
