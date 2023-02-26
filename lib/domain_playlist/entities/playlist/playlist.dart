import 'package:equatable/equatable.dart';
import '../entities.dart';
import '../../../domain_artist/entities/artist/mini_artist.dart';

import '../../../domain_song/entities/song_info.dart';

import '../../../domain_hub/entities/entities.dart';

class Playlist extends Equatable {
  final String? encodeId;
  final String? title;
  final String? thumbnail;
  final String? sortDescription;
  final int? releasedAt;
  final List<Genre>? genres;
  final SectionArtist? artists;
  final SectionSong? songs;
  final String? artistsNames;
  final String? thumbnailM;
  final String? userName;
  final String? description;

  @override
  List<Object?> get props => [
        encodeId,
        title,
        thumbnail,
        sortDescription,
        releasedAt,
        genres,
        artists,
        songs,
        artistsNames,
        thumbnailM,
        userName,
        description,
      ];

  @override
  bool? get stringify => true;

  const Playlist({
    this.encodeId,
    this.title,
    this.thumbnail,
    this.sortDescription,
    this.releasedAt,
    this.genres,
    this.artists,
    this.songs,
    this.artistsNames,
    this.thumbnailM,
    this.userName,
    this.description,
  });

  Playlist copyWith({
    String? encodeId,
    String? title,
    String? thumbnail,
    String? sortDescription,
    int? releasedAt,
    List<Genre>? genres,
    SectionArtist? artists,
    SectionSong? songs,
    String? artistsNames,
    String? thumbnailM,
    String? userName,
    String? description,
  }) {
    return Playlist(
      encodeId: encodeId ?? this.encodeId,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      sortDescription: sortDescription ?? this.sortDescription,
      releasedAt: releasedAt ?? this.releasedAt,
      genres: genres ?? this.genres,
      artists: artists ?? this.artists,
      songs: songs ?? this.songs,
      artistsNames: artistsNames ?? this.artistsNames,
      thumbnailM: thumbnailM ?? this.thumbnailM,
      userName: userName ?? this.userName,
      description: description ?? this.description,
    );
  }
}
