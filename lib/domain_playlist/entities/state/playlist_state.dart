import 'package:equatable/equatable.dart';
import 'package:musix/domain_hub/entities/entities.dart';
import 'package:musix/utils/enum/enum_status.dart';

import '../entities.dart';

class PlaylistState extends Equatable {
  final Map<String, Status>? status;
  final Playlist? playlist;
  final SectionPlaylist? sectionPlaylist;

  const PlaylistState({
    this.playlist,
    this.status,
    this.sectionPlaylist,
  });

  PlaylistState copyWith({
    Map<String, Status>? status,
    Playlist? playlist,
    SectionPlaylist? sectionPlaylist,
  }) {
    return PlaylistState(
      status: status ?? this.status,
      playlist: playlist ?? this.playlist,
      sectionPlaylist: sectionPlaylist ?? this.sectionPlaylist,
    );
  }

  @override
  List<Object?> get props => [
        status,
        playlist,
        sectionPlaylist,
      ];

  @override
  bool? get stringify => true;
}
