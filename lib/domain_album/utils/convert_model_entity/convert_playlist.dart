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
    songIds: model.song?.items?.map((e) => e.encodeId ?? '').toList(),
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
    id: model.encodeId!,
    name: model.title!,
    audioUrl: '',
    lyricUrl: '',
    artistName: model.artistsNames!,
    artistLink: '',
    thumbnailUrl: model.thumbnail!,
  );
}
