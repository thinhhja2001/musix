import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../entities.dart';

class PlaylistsState extends Equatable {
  final Map<String, Status>? status;
  final List<MiniPlaylist>? playlists;
  final String? title;
  final String? thumbnail;

  const PlaylistsState({
    this.status,
    this.playlists,
    this.title,
    this.thumbnail,
  });

  PlaylistsState copyWith({
    Map<String, Status>? status,
    List<MiniPlaylist>? playlists,
    String? title,
    String? thumbnail,
  }) {
    return PlaylistsState(
      status: status ?? this.status,
      playlists: playlists ?? this.playlists,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props => [
        status,
        playlists?.length,
        title,
      ];

  @override
  bool? get stringify => true;
}
