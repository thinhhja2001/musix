import 'package:equatable/equatable.dart';
import 'package:musix/utils/utils.dart';

import '../entities.dart';

class UserRecordState extends Equatable {
  final Map<String, Status>? status;
  final ResponseException? error;
  final UserRecord? record;

  const UserRecordState({
    this.status,
    this.error,
    this.record,
  });

  UserRecordState copyWith({
    Map<String, Status>? status,
    ResponseException? error,
    UserRecord? record,
  }) {
    return UserRecordState(
      status: status ?? this.status,
      error: error ?? this.error,
      record: record ?? this.record,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        record,
      ];

  @override
  bool? get stringify => true;
}
