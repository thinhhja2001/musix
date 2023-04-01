import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../entities.dart';

class UserMusicState extends Equatable {
  final Map<String, Status>? status;
  final ResponseException? error;
  final UserMusic? music;

  const UserMusicState({
    this.status,
    this.music,
    this.error,
  });

  UserMusicState copyWith({
    Map<String, Status>? status,
    ResponseException? error,
    UserMusic? music,
  }) {
    return UserMusicState(
        status: status ?? this.status,
        error: error ?? this.error,
        music: music ?? this.music);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        music,
        status,
        error,
      ];
}
