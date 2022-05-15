import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService extends GetxService {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  ///
  late final PackageInfo _packageInfo;
  PackageInfo get packageInfo => _packageInfo;
  set packageInfo(PackageInfo value) => _packageInfo = value;

  ///
  final _appVersion = ''.obs;
  String get appVersion => _appVersion.value;
  set appVersion(String value) => _appVersion.value = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  Future<void> onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }
}
