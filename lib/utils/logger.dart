import 'package:logger/logger.dart';

class DebugLogger {
  static DebugLogger? _instance;
  static Logger? _logger;
  static Logger? _loggerBloc;

  DebugLogger._internal() {
    _loggerBloc = Logger();
    _logger = Logger();
    _instance = this;
  }
  String? limitMessage({required String message}) {
    if (message.length > 600) {
      message = message.substring(0, 600);
    }
    return message;
  }

  factory DebugLogger() => _instance ?? DebugLogger._internal();

  void logBLoc(message) {
    message = limitMessage(message: message);
    _loggerBloc?.v(message);
  }

  void log(message, [Object? error, StackTrace? stackTrace]) {
    message = limitMessage(message: message);
    _logger?.v(message, error, stackTrace);
  }

  void error(message, [Object? error, StackTrace? stackTrace]) {
    message = limitMessage(message: message);
    _logger?.e(message, error, stackTrace);
  }

  void debug(message, [Object? error, StackTrace? stackTrace]) {
    message = limitMessage(message: message);
    _logger?.d(message, error, stackTrace);
  }

  void info(message, [Object? error, StackTrace? stackTrace]) {
    message = limitMessage(message: message);
    _logger?.i(message, error, stackTrace);
  }

  void unKnown(message, [Object? error, StackTrace? stackTrace]) {
    message = limitMessage(message: message);
    _logger?.wtf(message, error, stackTrace);
  }

  void warning(message, [Object? error, StackTrace? stackTrace]) {
    message = limitMessage(message: message);
    _logger?.w(message, error, stackTrace);
  }
}
