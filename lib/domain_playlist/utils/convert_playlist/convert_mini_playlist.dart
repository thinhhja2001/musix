import '../../entities/entities.dart';
import '../../models/models.dart';

MiniPlaylist? convertMiniPlaylistFromPlaylistModel(PlaylistModel? model) {
  if (model == null) {
    return null;
  }
  return MiniPlaylist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnailM: model.thumbnailM,
    artistsNames: model.artistsNames,
  );
}

MiniPlaylist? convertMiniPlaylistFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  final model = PlaylistModel.fromJson(json);
  return MiniPlaylist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnailM: model.thumbnailM,
    artistsNames: model.artistsNames,
  );
}
