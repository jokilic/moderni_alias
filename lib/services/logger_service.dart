import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoggerService extends GetxService {
  /// ------------------------
  /// VARIABLES
  /// ------------------------

  late final Logger _logger;

  /// ------------------------
  /// GETTERS
  /// ------------------------

  Logger get logger => _logger;

  /// ------------------------
  /// SETTERS
  /// ------------------------

  set logger(Logger value) => _logger = value;

  /// ------------------------
  /// INIT
  /// ------------------------

  @override
  void onInit() {
    super.onInit();
    logger = Logger();
  }

  /// ------------------------
  /// METHODS
  /// ------------------------

  set d(value) => logger.d(value);
  set e(value) => logger.e(value);
  set i(value) => logger.i(value);
  set v(value) => logger.v(value);
  set w(value) => logger.w(value);
  set wtf(value) => logger.wtf(value);
}
