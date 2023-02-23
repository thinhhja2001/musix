import 'package:musix/domain_album/entities/entities.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/domain_artist/utils/convert_mini_artist.dart';

import '../../../domain_music/utils/convert_songs/convert_songs.dart';

Playlist? convertPlaylistModel(PlaylistModel? model) {
  if (model == null) {
    return null;
  }
  return Playlist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnail: model.thumbnail,
    sortDescription: model.sortDescription,
    releasedAt: model.releasedAt,
    genreIds: model.genreIds,
    artists: model.artists
        ?.map((e) => convertMiniArtist(e))
        .where((element) => element != null)
        .toList(),
    songs: model.song?.items
        ?.map((e) => convertSongModel(e))
        .where((element) => element != null)
        .toList(),
    artistsNames: model.artistsNames,
    thumbnailM: model.thumbnailM,
    userName: model.userName,
    description: model.description,
  );
}
