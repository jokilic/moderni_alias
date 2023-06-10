import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final loggerProvider = Provider<LoggerService>(
  (_) => throw UnimplementedError(),
  name: 'LoggerProvider',
);

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

class RiverpodLogger extends ProviderObserver {
  final LoggerService logger;

  RiverpodLogger(this.logger);

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    logger.d('${provider.name ?? provider.runtimeType} has been initialized');
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    logger.d('${provider.name ?? provider.runtimeType} has been disposed');
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      logger.i('${provider.name ?? provider.runtimeType}] updated\n$newValue');
}
