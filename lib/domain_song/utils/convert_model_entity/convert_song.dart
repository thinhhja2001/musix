import '../../entities/entities.dart';
import '../../models/models.dart';

SongInfo? convertSongInfoModel(SongInfoModel songInfoModel) => SongInfo(
    encodeId: songInfoModel.encodeId,
    albumId: songInfoModel.albumId,
    artistsId: songInfoModel.artistsId,
    artistsNames: songInfoModel.artistsNames,
    genreIds: songInfoModel.genreIds,
    thumbnailM: songInfoModel.thumbnailM,
    title: songInfoModel.title);

SongInfoModel? convertSongInfo(SongInfo songInfo) => SongInfoModel(
    encodeId: songInfo.encodeId,
    albumId: songInfo.albumId,
    artistsId: songInfo.artistsId,
    artistsNames: songInfo.artistsNames,
    genreIds: songInfo.genreIds,
    thumbnailM: songInfo.thumbnailM,
    title: songInfo.title);

SongSource? convertSongSourceModel(SongSourceModel songSourceModel) =>
    SongSource(
        audioUrl: songSourceModel.audioUrl, lyricUrl: songSourceModel.lyricUrl);

SongInfo? convertSongInfoFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  final songInfoModel = SongInfoModel.fromJson(json);
  return SongInfo(
      encodeId: songInfoModel.encodeId,
      albumId: songInfoModel.albumId,
      artistsId: songInfoModel.artistsId,
      artistsNames: songInfoModel.artistsNames,
      genreIds: songInfoModel.genreIds,
      thumbnailM: songInfoModel.thumbnailM,
      title: songInfoModel.title);
}
