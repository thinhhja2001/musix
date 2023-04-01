import 'package:equatable/equatable.dart';

class ResponseException extends Equatable implements Exception {
  final int? statusCode;
  final String? message;

  const ResponseException({
    this.statusCode,
    this.message,
  });

  ResponseException copyWith({
    int? statusCode,
    String? message,
  }) {
    return ResponseException(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        statusCode,
        message,
      ];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return '[$statusCode]: $message';
  }
}
