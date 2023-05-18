import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final loggerProvider = Provider<LoggerService>((ref) => LoggerService());

class LoggerService {
  ///
  /// CONSTRUCTOR
  ///

  LoggerService() {
    init();
  }

  ///
  /// VARIABLES
  ///

  late final Logger logger;

  ///
  /// INIT
  ///

  void init() => logger = Logger(
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
