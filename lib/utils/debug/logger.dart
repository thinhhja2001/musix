import 'dart:developer' as dev;

import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class DebugLogger {
  static DebugLogger? _instance;
  static Logger? _logger;
  static final _dateFormatter = DateFormat('H:m:s.S');
  static const appName = 'musix';

  DebugLogger._internal() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(_recordHandler);

    _logger = Logger(appName);

    _instance = this;
  }

  factory DebugLogger() => _instance ?? DebugLogger._internal();

  void _recordHandler(LogRecord rec) {
    String? message;
    message = rec.message;
    dev.log('${_dateFormatter.format(rec.time)}: $message)}');
  }

  void log(message, [Object? error, StackTrace? stackTrace]) =>
      _logger?.info(message, error, stackTrace);

  void logBLoc(message) {
    _logger?.info(message);
  }

  void error(message, [Object? error, StackTrace? stackTrace]) {
    _logger?.info(message, error, stackTrace);
  }

  void debug(message, [Object? error, StackTrace? stackTrace]) {
    _logger?.info(message, error, stackTrace);
  }

  void info(message, [Object? error, StackTrace? stackTrace]) {
    _logger?.info(message, error, stackTrace);
  }

  void unKnown(message, [Object? error, StackTrace? stackTrace]) {
    _logger?.info(message, error, stackTrace);
  }

  void warning(message, [Object? error, StackTrace? stackTrace]) {
    _logger?.info(message, error, stackTrace);
  }
}
