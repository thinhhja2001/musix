import 'package:musix/domain_global/models/get_hub_detail_model/get_hub_detail_model.dart';

import '../../entities/song_info.dart';
import '../../models/get_song_list_model/get_song_list_model.dart';

List<SongInfo?> convertSongsFromSections(SectionsModel? sectionsModel) {
  if (sectionsModel == null) return [];
  if (sectionsModel.sectionType != 'song') return [];
  final list = sectionsModel.items
      ?.map(
        (songJson) => convertSongModel(SongModel.fromJson(songJson)),
      )
      .where((songInfo) => songInfo != null)
      .toList();
  return list ?? [];
}

SongInfo? convertSongModel(SongModel? model) {
  if (model == null) {
    return null;
  }
  return SongInfo(
    encodeId: model.encodeId!,
    title: model.title!,
    artistsNames: model.artistsNames!,
    thumbnailM: model.thumbnailM!,
    genreIds: model.genreIds!,
    albumId: model.album?.encodeId,
    artistsId: model.artists?.map((e) => e.id ?? '').toList(),
  );
}
