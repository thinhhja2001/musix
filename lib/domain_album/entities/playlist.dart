import 'package:equatable/equatable.dart';

class Playlist extends Equatable {
  final String? encodeId;
  final String? title;
  final String? thumbnail;
  final bool? isoffical;
  final bool? isIndie;
  final String? sortDescription;
  final int? releasedAt;
  final List<String>? genreIds;
  final List<String>? artistIds;
  final List<String>? songIds;
  final String? artistsNames;
  final String? thumbnailM;
  final String? userName;
  final bool? isAlbum;
  final String? description;
  final String? aliasTitle;
  final String? sectionId;

  @override
  List<Object?> get props => [
        encodeId,
        title,
        thumbnail,
        isoffical,
        isIndie,
        sortDescription,
        releasedAt,
        genreIds,
        artistIds,
        songIds,
        artistsNames,
        thumbnailM,
        userName,
        description,
        aliasTitle,
        sectionId,
      ];

  @override
  bool? get stringify => true;

  const Playlist({
    this.encodeId,
    this.title,
    this.thumbnail,
    this.isoffical,
    this.isIndie,
    this.sortDescription,
    this.releasedAt,
    this.genreIds,
    this.artistIds,
    this.songIds,
    this.artistsNames,
    this.thumbnailM,
    this.userName,
    this.isAlbum,
    this.description,
    this.aliasTitle,
    this.sectionId,
  });

  Playlist copyWith({
    String? encodeId,
    String? title,
    String? thumbnail,
    bool? isoffical,
    bool? isIndie,
    String? sortDescription,
    int? releasedAt,
    List<String>? genreIds,
    List<String>? artistIds,
    List<String>? songIds,
    String? artistsNames,
    String? thumbnailM,
    String? userName,
    bool? isAlbum,
    String? description,
    String? aliasTitle,
    String? sectionId,
  }) {
    return Playlist(
      encodeId: encodeId ?? this.encodeId,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      isoffical: isoffical ?? this.isoffical,
      isIndie: isIndie ?? this.isIndie,
      sortDescription: sortDescription ?? this.sortDescription,
      releasedAt: releasedAt ?? this.releasedAt,
      genreIds: genreIds ?? this.genreIds,
      artistIds: artistIds ?? this.artistIds,
      songIds: songIds ?? this.songIds,
      artistsNames: artistsNames ?? this.artistsNames,
      thumbnailM: thumbnailM ?? this.thumbnailM,
      userName: userName ?? this.userName,
      isAlbum: isAlbum ?? this.isAlbum,
      description: description ?? this.description,
      aliasTitle: aliasTitle ?? this.aliasTitle,
      sectionId: sectionId ?? this.sectionId,
    );
  }
}
