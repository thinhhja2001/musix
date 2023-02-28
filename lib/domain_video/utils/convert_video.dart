import 'package:musix/domain_artist/entities/artist/artist.dart';
import 'package:musix/domain_artist/utils/convert_artist/convert_artist.dart';

import '../entities/video_detail.dart';
import '../entities/video_short.dart';
import '../models/models.dart';

VideoShort convertVideoShortModel(VideoShortModel videoShortModel) =>
    VideoShort(
      encodeID: videoShortModel.encodeID,
      albumId: videoShortModel.albumId,
      artists: videoShortModel.artists
          ?.map((artist) => convertArtistFromModel(artist))
          .toList()
          .cast<Artist>(),
      artistsNames: videoShortModel.artistsNames,
      genreIds: videoShortModel.genreIds,
      thumbnailM: videoShortModel.thumbnailM,
      title: videoShortModel.title,
      duration: videoShortModel.duration,
    );

VideoDetail convertVideoDetailModel(VideoDetailModel videoDetailModel) =>
    VideoDetail(
      encodeID: videoDetailModel.encodeID,
      albumId: videoDetailModel.albumId,
      artists: videoDetailModel.artists
          ?.map((artist) => convertArtistFromModel(artist))
          .toList()
          .cast<Artist>(),
      artistsNames: videoDetailModel.artistsNames,
      genreIds: videoDetailModel.genreIds,
      thumbnailM: videoDetailModel.thumbnailM,
      title: videoDetailModel.title,
      videoUrl: videoDetailModel.videoUrl,
      duration: videoDetailModel.duration,
      createdAt: videoDetailModel.createdAt,
      recommends: videoDetailModel.recommends
          ?.map((recommend) => convertVideoShortModel(recommend))
          .toList()
          .cast<VideoShort>(),
    );
