import '../../entities/entities.dart';
import '../../models/playlist/playlist_model.dart';

MiniPlaylist? convertMiniPlaylistFromPlaylistModel(PlaylistModel? model) {
  if (model == null) {
    return null;
  }
  return MiniPlaylist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnailM: model.thumbnail,
    artistsNames: model.artistsNames,
  );
}

MiniPlaylist? convertMiniPlaylistFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  final model = PlaylistModel.fromJson(json);
  return MiniPlaylist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnailM: model.thumbnail,
    artistsNames: model.artistsNames,
  );
}
