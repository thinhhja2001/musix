import 'package:equatable/equatable.dart';
import 'package:musix/utils/enum/enum_status.dart';

import '../entities.dart';

class PlaylistState extends Equatable {
  final Map<String, Status>? status;
  final Playlist? playlist;

  const PlaylistState({
    this.playlist,
    this.status,
  });

  PlaylistState copyWith({
    Map<String, Status>? status,
    Playlist? playlist,
  }) {
    return PlaylistState(
      status: status ?? this.status,
      playlist: playlist ?? this.playlist,
    );
  }

  @override
  List<Object?> get props => [
        status,
        playlist,
      ];

  @override
  bool? get stringify => true;
}
