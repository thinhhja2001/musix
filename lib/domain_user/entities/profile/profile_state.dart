import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../entities.dart';

class ProfileState extends Equatable {
  final Map<String, Status>? status;
  final User? user;
  final ResponseException? error;

  const ProfileState({
    this.user,
    this.status,
    this.error,
  });

  ProfileState copyWith({
    Map<String, Status>? status,
    User? user,
    ResponseException? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        error,
      ];

  @override
  bool? get stringify => true;
}
