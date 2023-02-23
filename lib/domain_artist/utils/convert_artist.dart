import 'package:musix/domain_album/utils/convert_playlist/convert_mini_playlist.dart';
import 'package:musix/domain_artist/entities/entities.dart';
import 'package:musix/domain_artist/models/get_artist_model/get_artist_model.dart';
import 'package:musix/domain_music/utils/convert_songs/convert_songs.dart';

Artist? convertArtistFromModel(ArtistModel? artistModel) {
  if (artistModel == null) return null;
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
    topics: artistModel.sections
        ?.map((e) => convertTopicFromHubSection(e))
        .where((element) => element != null)
        .toList(),
    songs: artistModel.sections?.map((e) => convertSongsFromSections(e)).first,
  );
}
