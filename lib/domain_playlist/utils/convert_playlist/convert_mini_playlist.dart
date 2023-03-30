import '../../entities/entities.dart';
import '../../models/playlist/playlist_model.dart';

MiniPlaylist? convertMiniPlaylistFromPlaylistModel(PlaylistModel? model) {
  if (model == null) {
    return null;
  }
  if (model.title == null || model.encodeId == null) {
    return null;
  }
  List<String>? artistAlias =
      model.artists?.map((artist) => artist.alias!).toList();
  List<String>? genres = model.genres?.map((e) => e.name!).toList();
  return MiniPlaylist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnailM: model.thumbnail ?? model.thumbnailM,
    artistsNames: model.artistsNames,
    artistAlias: artistAlias,
    genres: genres,
    countSong: model.song?.total,
  );
}

MiniPlaylist? convertMiniPlaylistFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  final model = PlaylistModel.fromJson(json);
  return convertMiniPlaylistFromPlaylistModel(model);
}
