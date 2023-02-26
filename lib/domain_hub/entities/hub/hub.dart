import 'package:equatable/equatable.dart';

import '../entities.dart';

class Hub extends Equatable {
  final String? encodeId;
  final String? cover;
  final String? title;
  final String? description;
  final List<SectionArtist>? artists;
  final List<SectionPlaylist>? playlists;
  final List<SectionSong>? songs;

  const Hub({
    this.encodeId,
    this.cover,
    this.title,
    this.description,
    this.artists,
    this.playlists,
    this.songs,
  });

  Hub copyWith({
    String? encodeId,
    String? cover,
    String? title,
    String? description,
    List<SectionArtist>? artists,
    List<SectionPlaylist>? playlists,
    List<SectionSong>? songs,
  }) {
    return Hub(
      encodeId: encodeId ?? this.encodeId,
      cover: cover ?? this.cover,
      title: title ?? this.title,
      description: description ?? this.description,
      artists: artists ?? this.artists,
      playlists: playlists ?? this.playlists,
      songs: songs ?? this.songs,
    );
  }

  @override
  List<Object?> get props => [
        encodeId,
        cover,
        title,
        description,
        artists,
        playlists,
        songs,
      ];

  @override
  bool? get stringify => true;
}
