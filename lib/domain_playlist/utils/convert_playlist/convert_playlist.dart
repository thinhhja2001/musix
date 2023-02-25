import '../../../domain_artist/entities/entities.dart';
import '../../../domain_artist/utils/utils.dart';
import '../../../domain_hub/entities/entities.dart';
import '../../../domain_hub/utils/utils.dart';
import '../../../domain_music/entities/entities.dart';
import '../../../domain_music/utils/utils.dart';
import '../../entities/entities.dart';
import '../../models/models.dart';

Playlist? convertPlaylistModel(PlaylistModel? model) {
  if (model == null) {
    return null;
  }

  List<Genre>? genres =
      model.genres?.map((genreModel) => convertGenre(genreModel)!).toList();

  List<SongInfo>? songList = model.song?.items
      ?.map((songInfoModel) => convertSongInfoModel(songInfoModel)!)
      .toList();
  SectionSong songs = SectionSong(
    title: 'All',
    items: songList,
  );

  List<MiniArtist>? artistList = model.artists
      ?.map((artistModel) => convertMiniArtistFromModel(artistModel)!)
      .toList();
  SectionArtist artists = SectionArtist(
    title: 'Artists',
    items: artistList,
  );

  return Playlist(
    encodeId: model.encodeId,
    title: model.title,
    thumbnail: model.thumbnail,
    sortDescription: model.sortDescription,
    releasedAt: model.releasedAt,
    genres: genres,
    artists: artists,
    songs: songs,
    artistsNames: model.artistsNames,
    thumbnailM: model.thumbnailM ?? model.thumbnail,
    userName: model.userName,
    description: model.description,
  );
}
