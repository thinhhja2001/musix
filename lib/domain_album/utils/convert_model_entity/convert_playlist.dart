import 'package:musix/domain_album/entities/entities.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/domain_music/models/models.dart';

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
    albumId: model.album!.encodeId,
    artistsId: model.artists?.map((e) => e.id!).toList(),
  );
}
