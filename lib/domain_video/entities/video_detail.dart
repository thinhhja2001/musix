import 'package:equatable/equatable.dart';
import '../../domain_artist/entities/artist/artist.dart';
import 'video_short.dart';

class VideoDetail extends Equatable {
  final String? encodeID;
  final String? title;
  final String? artistsNames;
  final String? thumbnailM;
  final List? genreIds;
  final String? albumId;
  final List<Artist>? artists;
  final String? videoUrl;
  final int? duration;
  final DateTime? createdAt;
  final List<VideoShort>? recommends;
  const VideoDetail({
    this.encodeID,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artists,
    this.videoUrl,
    this.duration,
    this.createdAt,
    this.recommends,
  });
  @override
  List<Object?> get props => [
        encodeID,
        title,
        artistsNames,
        thumbnailM,
        genreIds,
        albumId,
        artists,
        videoUrl,
        duration,
        createdAt,
        recommends
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
    List<Artist>? artists,
    String? videoUrl,
    int? duration,
    DateTime? createdAt,
    List<VideoShort>? recommends,
  }) =>
      VideoDetail(
        encodeID: encodeID ?? this.encodeID,
        title: title ?? this.title,
        artistsNames: artistsNames ?? this.artistsNames,
        thumbnailM: thumbnailM ?? this.thumbnailM,
        genreIds: genreIds ?? this.genreIds,
        albumId: albumId ?? this.albumId,
        artists: artists ?? this.artists,
        videoUrl: videoUrl ?? this.videoUrl,
        duration: duration ?? this.duration,
        createdAt: createdAt ?? this.createdAt,
        recommends: recommends ?? this.recommends,
      );
}
