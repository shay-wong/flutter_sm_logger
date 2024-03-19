import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

const consoleOutputLength = 90;

/// 是否打印日志, 默认为 [kDebugMode]
bool get kPrintable => const bool.fromEnvironment("PRINTABLE", defaultValue: kDebugMode);

final logger = MLogger(
  filter: MLogFilter(),
  level: Level.all,
  printer: PrettyPrinter(
    printTime: true,
    lineLength: consoleOutputLength,
    methodCount: 3,
    excludePaths: [
      'packages/flutter_sm_logger/src/logger.dart',
    ],
  ),
);

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
    super.filter,
    super.printer,
    super.output,
    super.level,
  });

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
