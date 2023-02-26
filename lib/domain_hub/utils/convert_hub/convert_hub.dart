import '../../entities/entities.dart';
import '../../model/model.dart';
import '../utils.dart';

List<Hub> convertHubFromGetHomeHub(GetHomeHubModel model) {
  List<Hub> hubs = [];

  model.data?.topic?.forEach((e) {
    hubs.add(convertHubFromHubModel(e));
  });

  return hubs;
}

Hub convertHubFromHubModel(HubModel model) {
  List<SectionPlaylist>? playlists = [];
  List<SectionArtist>? artists = [];
  List<SectionSong>? songs = [];

  model.sections?.forEach((e) {
    if (e.sectionType!.contains('playlist')) {
      playlists.add(convertSectionPlaylistFromModel(e)!);
    } else if (e.sectionType!.contains('song')) {
      songs.add(convertSectionSongFromModel(e)!);
    } else if (e.sectionType!.contains('artist')) {
      artists.add(convertSectionArtistFromModel(e)!);
    }
  });
  return Hub(
    encodeId: model.encodeId,
    cover: model.cover,
    title: model.title,
    description: model.description,
    artists: artists,
    playlists: playlists,
    songs: songs,
  );
}
