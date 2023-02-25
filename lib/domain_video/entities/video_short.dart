import 'package:equatable/equatable.dart';

class VideoShort extends Equatable {
  final String? encodeID;
  final String? title;
  final String? artistsNames;
  final String? thumbnailM;
  final List? genreIds;
  final String? albumId;
  final List? artistsId;
  const VideoShort({
    this.encodeID,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artistsId,
  });
  @override
  List<Object?> get props => [
        encodeID,
        title,
        artistsNames,
        thumbnailM,
        genreIds,
        albumId,
        artistsId,
      ];

  @override
  bool? get stringify => true;

  VideoShort copyWith({
    String? encodeID,
    String? title,
    String? artistsNames,
    String? thumbnailM,
    List? genreIds,
    String? albumId,
    List? artistsId,
  }) =>
      VideoShort(
        encodeID: encodeID ?? this.encodeID,
        title: title ?? this.title,
        artistsNames: artistsNames ?? this.artistsNames,
        thumbnailM: thumbnailM ?? this.thumbnailM,
        genreIds: genreIds ?? this.genreIds,
        albumId: albumId ?? this.albumId,
        artistsId: artistsId ?? this.artistsId,
      );
}
