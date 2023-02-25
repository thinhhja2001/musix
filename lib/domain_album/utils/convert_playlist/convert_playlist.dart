import '../../entities/entities.dart';
import '../../models/models.dart';
import '../../../domain_artist/utils/convert_mini_artist.dart';

import '../../../domain_song/utils/convert_songs/convert_songs.dart';
import '../convert_genre/convert_genre.dart';

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
    genres: model.genres
        ?.map((e) => convertGenre(e))
        .where((element) => element != null)
        .toList(),
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
