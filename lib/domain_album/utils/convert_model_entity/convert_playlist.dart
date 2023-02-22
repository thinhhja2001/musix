import 'package:musix/domain_album/entities/entities.dart';
import 'package:musix/domain_album/models/models.dart';

import '../../../domain_music/entities/song.dart';

Playlist? convertPlaylistModel(PlaylistModel? model) {
  if (model == null) {
    return null;
  }
  return Playlist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnail: model.thumbnail,
    isoffical: model.isoffical,
    isIndie: model.isIndie,
    sortDescription: model.sortDescription,
    releasedAt: model.releasedAt,
    genreIds: model.genreIds,
    artistIds: model.artists?.map((e) => e.id ?? '').toList(),
    songs: model.song?.items?.map((e) => convertSongModel(e)).toList(),
    artistsNames: model.artistsNames,
    thumbnailM: model.thumbnailM,
    userName: model.userName,
    isAlbum: model.isAlbum,
    description: model.description,
    aliasTitle: model.aliasTitle,
    sectionId: model.sectionId,
  );
}

Song? convertSongModel(SongModel? model) {
  if (model == null) {
    return null;
  }
  return Song(
    encodeId: model.encodeId,
    title: model.title,
    alias: model.alias,
    isOffical: model.isOffical,
    username: model.username,
    artistsNames: model.artistsNames,
    artistIds: model.artists?.map((e) => e.id ?? '').toList(),
    thumbnailM: model.thumbnailM,
    thumbnail: model.thumbnail,
    duration: model.duration,
    releaseDate: model.releaseDate,
    genreIds: model.genreIds,
    radioId: model.radioId,
    hasLyric: model.hasLyric,
    mvlink: model.mvlink,
  );
}
