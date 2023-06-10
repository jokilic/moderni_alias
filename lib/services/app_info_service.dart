import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final appInfoProvider = FutureProvider<AppInfoService>((ref) async {
  final appInfoService = AppInfoService();
  await appInfoService.init();
  return appInfoService;
});

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
