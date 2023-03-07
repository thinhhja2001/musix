import 'package:musix/domain_hub/model/model.dart';

import '../../../domain_hub/utils/convert_section/convert_section.dart';

import '../../../domain_hub/entities/entities.dart';
import '../../entities/entities.dart';
import '../../models/models.dart';

Artist? convertArtistFromModel(ArtistModel? artistModel) {
  if (artistModel == null) return null;

  List<SectionPlaylist>? playlists = [];
  SectionSong? songs;

  artistModel.sections?.forEach((element) {
    if (element.sectionType == 'playlist') {
      playlists.add(convertSectionPlaylistFromModel(element)!);
    }
    if (songs == null && element.sectionType == 'song') {
      songs = convertSectionSongFromModel(element);
    }
  });

  return Artist(
    id: artistModel.id,
    name: artistModel.name,
    alias: artistModel.alias,
    playlistId: artistModel.playlistId,
    cover: artistModel.cover,
    biography: artistModel.biography,
    sortBiography: artistModel.sortBiography,
    thumbnailM: artistModel.thumbnailM,
    national: artistModel.national,
    birthday: artistModel.birthday,
    realname: artistModel.realname,
    sectionPlaylist: playlists,
    songs: songs,
  );
}
