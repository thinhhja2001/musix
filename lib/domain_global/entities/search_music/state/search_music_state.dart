import 'package:equatable/equatable.dart';

import '../../../../domain_hub/entities/entities.dart';
import '../../../../utils/utils.dart';
import '../all_searching.dart';

class SearchMusicState extends Equatable {
  final Map<String, Status>? status;
  final String? query;
  final SectionAll? all;
  final SectionSong? songs;
  final SectionArtist? artists;
  final SectionPlaylist? playlists;
  final SectionVideo? videos;
  final Map<MusicType, int>? currentPage;

  const SearchMusicState({
    this.status,
    this.query,
    this.all,
    this.songs,
    this.artists,
    this.playlists,
    this.videos,
    this.currentPage,
  });

  SearchMusicState copyWith({
    Map<String, Status>? status,
    String? query,
    SectionAll? all,
    SectionSong? songs,
    SectionArtist? artists,
    SectionPlaylist? playlists,
    SectionVideo? videos,
    Map<MusicType, int>? currentPage,
  }) {
    return SearchMusicState(
      status: status ?? this.status,
      query: query ?? this.query,
      all: all ?? this.all,
      songs: songs ?? this.songs,
      playlists: playlists ?? this.playlists,
      videos: videos ?? this.videos,
      artists: artists ?? this.artists,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        query,
        all?.total,
        songs?.total,
        artists?.total,
        playlists?.total,
      ];

  @override
  bool? get stringify => true;
}
