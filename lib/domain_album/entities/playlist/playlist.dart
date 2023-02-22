import 'package:equatable/equatable.dart';
import 'package:musix/domain_music/models/models.dart';

class Playlist extends Equatable {
  final String? encodeId;
  final String? title;
  final String? thumbnail;
  final String? sortDescription;
  final int? releasedAt;
  final List<String>? genreIds;
  final List<String>? artistIds;
  final List<SongInfo?>? songs;
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
        genreIds,
        artistIds,
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
    this.genreIds,
    this.artistIds,
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
    List<String>? genreIds,
    List<String>? artistIds,
    List<SongInfo?>? songs,
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
      genreIds: genreIds ?? this.genreIds,
      artistIds: artistIds ?? this.artistIds,
      songs: songs ?? this.songs,
      artistsNames: artistsNames ?? this.artistsNames,
      thumbnailM: thumbnailM ?? this.thumbnailM,
      userName: userName ?? this.userName,
      description: description ?? this.description,
    );
  }
}
