import '../../entities/entities.dart';

import '../../../domain_global/models/get_hub_detail_model/get_hub_detail_model.dart';
import '../../models/playlist/get_playlist_model.dart';

Topic? convertTopicFromHubSection(SectionsModel? sectionsModel) {
  if (sectionsModel == null) return null;
  if (sectionsModel.sectionType != 'playlist') return null;
  return Topic(
    title: sectionsModel.title,
    items: sectionsModel.items
        ?.map(
          (e) => convertMiniPlaylistModel(convertPlaylistModelFromHubItem(e))!,
        )
        .toList(),
  );
}

PlaylistModel? convertPlaylistModelFromHubItem(Map<String, dynamic>? json) {
  if (json == null) {
    return null;
  }
  return PlaylistModel.fromJson(json);
}

MiniPlaylist? convertMiniPlaylistModel(PlaylistModel? model) {
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
