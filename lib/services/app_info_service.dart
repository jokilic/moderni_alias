import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService extends GetxService {
  /// ------------------------
  /// REACTIVE VARIABLES
  /// ------------------------

  final _appVersion = ''.obs;
  String get appVersion => _appVersion.value;
  set appVersion(String value) => _appVersion.value = value;

  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final PackageInfo packageInfo;

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
