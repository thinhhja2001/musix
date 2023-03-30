import 'package:equatable/equatable.dart';

class SongInfo extends Equatable {
  const SongInfo({
    this.encodeId,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artistsId,
    this.genreNames,
  });

  final String? encodeId;
  final String? title;
  final String? artistsNames;
  final String? thumbnailM;
  final List<String>? genreIds;
  final List<String>? genreNames;
  final String? albumId;
  final List<String>? artistsId;

  @override
  List<Object?> get props => [
        encodeId,
        title,
        artistsNames,
        thumbnailM,
        genreIds,
        albumId,
        artistsId,
        genreNames,
      ];

  @override
  bool? get stringify => true;

  SongInfo copyWith({
    encodeId,
    title,
    artistsNames,
    thumbnailM,
    genreIds,
    albumId,
    artistsId,
    genreNames,
  }) =>
      SongInfo(
        encodeId: encodeId ?? this.encodeId,
        title: title ?? this.title,
        artistsNames: artistsNames ?? this.artistsNames,
        thumbnailM: thumbnailM ?? this.thumbnailM,
        genreIds: genreIds ?? this.genreIds,
        albumId: albumId ?? this.albumId,
        artistsId: artistsId ?? this.artistsId,
        genreNames: genreNames ?? this.genreNames,
      );
}
