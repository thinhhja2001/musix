import '../entities/video_detail.dart';
import '../entities/video_short.dart';
import '../models/models.dart';

VideoShort convertVideoShortModel(VideoShortModel videoShortModel) =>
    VideoShort(
      encodeID: videoShortModel.encodeID,
      albumId: videoShortModel.albumId,
      artistsId: videoShortModel.artistsId,
      artistsNames: videoShortModel.artistsNames,
      genreIds: videoShortModel.genreIds,
      thumbnailM: videoShortModel.thumbnailM,
      title: videoShortModel.title,
    );

VideoDetail convertVideoDetailModel(VideoDetailModel videoDetailModel) =>
    VideoDetail(
      encodeID: videoDetailModel.encodeID,
      albumId: videoDetailModel.albumId,
      artistsId: videoDetailModel.artistsId,
      artistsNames: videoDetailModel.artistsNames,
      genreIds: videoDetailModel.genreIds,
      thumbnailM: videoDetailModel.thumbnailM,
      title: videoDetailModel.title,
      videoUrl: videoDetailModel.videoUrl,
    );
