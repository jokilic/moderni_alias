import 'package:get/get.dart';

import 'logger_service.dart';

class LifecycleService extends SuperController {
  final logger = Get.find<LoggerService>();

  @override
  void onDetached() => logger.d('onDetached');

  @override
  void onInactive() => logger.d('onInactive');

  @override
  void onPaused() => logger.d('onPaused');

  @override
  void onResumed() => logger.d('onResumed');
}
