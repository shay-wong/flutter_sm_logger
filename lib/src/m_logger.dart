import 'package:logger/logger.dart';

import 'm_print.dart';

const consoleOutputLength = 90;
const methodCount = 3;
const errorMethodCount = 8;

const bool _kProfileMode = bool.fromEnvironment('dart.vm.profile');
const bool _kReleaseMode = bool.fromEnvironment('dart.vm.product');
const bool _kDebugMode = !_kReleaseMode && !_kProfileMode;
/// 是否打印日志, 默认为 [kDebugMode]
bool get kPrintable => const bool.fromEnvironment("PRINTABLE", defaultValue: _kDebugMode);

final logger = MLogger();

class MPrettyPrinter extends PrettyPrinter {
  MPrettyPrinter({
    super.stackTraceBeginIndex = 0,
    super.methodCount = methodCount,
    super.errorMethodCount = errorMethodCount,
    super.lineLength = consoleOutputLength,
    super.colors = true,
    super.printEmojis = true,
    super.printTime = true,
    super.excludeBox = const {},
    super.noBoxingByDefault = false,
    List<String> excludePaths = const [],
    super.levelColors,
    super.levelEmojis,
  }) : super(
          excludePaths: [
            ...excludePaths,
            // 默认排除掉 sm_ 库相关的日志
            'packages/sm_',
            'package:sm_',
          ],
        );
}

class MLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    var shouldLog = false;
    if (kPrintable) {
      if (event.level.value >= level!.value) {
        shouldLog = true;
      }
      return true;
    }
    return shouldLog;
  }
}

class MLogger extends Logger {
  MLogger({
    LogFilter? filter,
    LogPrinter? printer,
    super.output,
    Level? level,
  }) : super(
          filter: filter ?? MLogFilter(),
          printer: printer ?? MPrettyPrinter(),
          level: level ?? Level.all,
        );

  /// Log a message at level [Level.debug].
  @override
  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.debug, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.error].
  @override
  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.error, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.fatal].
  @override
  void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.fatal, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.info].
  @override
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.info, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.debug].
  @override
  void log(
    Level level,
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    super.log(level, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.trace].
  @override
  void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.trace, message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.warning].
  @override
  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(Level.warning, message, time: time, error: error, stackTrace: stackTrace);
  }

  void p(dynamic message) {
    if (kPrintable) debugPrint('$message');
  }
}
