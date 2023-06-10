import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final appInfoProvider = FutureProvider.autoDispose<AppInfoService>(
  (ref) async {
    final appInfoService = AppInfoService();
    await appInfoService.init();
    return appInfoService;
  },
  name: 'AppInfoProvider',
);

class AppInfoService {
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
