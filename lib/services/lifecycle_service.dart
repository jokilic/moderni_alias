import 'dart:developer';

import 'package:get/get.dart';

class LifecycleService extends SuperController {
  @override
  void onDetached() => log('onDetached');

  @override
  void onInactive() => log('onInactive');

  @override
  void onPaused() => log('onPaused');

  @override
  void onResumed() => log('onResumed');
}
