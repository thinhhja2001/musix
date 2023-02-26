import 'package:equatable/equatable.dart';

class VideoDetail extends Equatable {
  final String? encodeID;
  final String? title;
  final String? artistsNames;
  final String? thumbnailM;
  final List? genreIds;
  final String? albumId;
  final List? artistsId;
  final String? videoUrl;

  const VideoDetail({
    this.encodeID,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artistsId,
    this.videoUrl,
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
        videoUrl
      ];

  @override
  bool? get stringify => true;

  VideoDetail copyWith({
    String? encodeID,
    String? title,
    String? artistsNames,
    String? thumbnailM,
    List? genreIds,
    String? albumId,
    List? artistsId,
    String? videoUrl,
  }) =>
      VideoDetail(
        encodeID: encodeID ?? this.encodeID,
        title: title ?? this.title,
        artistsNames: artistsNames ?? this.artistsNames,
        thumbnailM: thumbnailM ?? this.thumbnailM,
        genreIds: genreIds ?? this.genreIds,
        albumId: albumId ?? this.albumId,
        artistsId: artistsId ?? this.artistsId,
        videoUrl: videoUrl ?? this.videoUrl,
      );
}
