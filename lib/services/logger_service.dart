import 'package:get/get.dart';
import 'package:logger_fork/logger_fork.dart';

class LoggerService extends GetxService {
  ///
  /// VARIABLES
  ///

  late final Logger logger;

  ///
  /// INIT
  ///

  @override
  void onInit() {
    super.onInit();
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 3,
        lineLength: 50,
        noBoxingByDefault: true,
      ),
    );
  }

  ///
  /// METHODS
  ///

  /// Verbose log, grey color
  void v(value) => logger.v(value);

  /// 🐛 Debug log, blue color
  void d(value) => logger.d(value);

  /// 💡 Info log, light blue color
  void i(value) => logger.i(value);

  /// ⚠️ Warning log, orange color
  void w(value) => logger.w(value);

  /// ⛔ Error log, red color
  void e(value) => logger.e(value);

  /// 👾 What a terrible failure error, purple color
  void wtf(value) => logger.wtf(value);
}
