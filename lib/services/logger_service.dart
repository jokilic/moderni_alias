import 'package:logger/logger.dart';

class LoggerService {
  ///
  /// VARIABLES
  ///

  late final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 50,
      noBoxingByDefault: true,
    ),
  );

  ///
  /// METHODS
  ///

  /// Trace log, grey color
  void t(value) => logger.t(value);

  /// 🐛 Debug log, blue color
  void d(value) => logger.d(value);

  /// 💡 Info log, light blue color
  void i(value) => logger.i(value);

  /// ⚠️ Warning log, orange color
  void w(value) => logger.w(value);

  /// ⛔ Error log, red color
  void e(value) => logger.e(value);

  /// 👾 Fatal error, purple color
  void f(value) => logger.f(value);
}
