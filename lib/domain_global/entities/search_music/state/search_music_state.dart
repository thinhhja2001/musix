import 'package:equatable/equatable.dart';

import '../../../../domain_hub/entities/entities.dart';
import '../../../../utils/enum/enum_status.dart';
import '../all_searching.dart';

class SearchMusicState extends Equatable {
  final Map<String, Status>? status;
  final String? query;
  final SectionAll? all;
  final SectionSong? songs;
  final SectionArtist? artists;
  final SectionPlaylist? playlists;
  final SectionVideo? videos;

  const SearchMusicState({
    this.status,
    this.query,
    this.all,
    this.songs,
    this.artists,
    this.playlists,
    this.videos,
  });

  SearchMusicState copyWith({
    Map<String, Status>? status,
    String? query,
    SectionAll? all,
    SectionSong? songs,
    SectionArtist? artists,
    SectionPlaylist? playlists,
    SectionVideo? videos,
  }) {
    return SearchMusicState(
      status: status ?? this.status,
      query: query ?? this.query,
      all: all ?? this.all,
      songs: songs ?? this.songs,
      playlists: playlists ?? this.playlists,
      videos: videos ?? this.videos,
    );
  }

  @override
  List<Object?> get props => [
        status,
        query,
      ];

  @override
  bool? get stringify => true;
}
