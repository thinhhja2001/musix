import '../../../domain_video/utils/convert_video.dart';

import '../../../domain_artist/entities/entities.dart';
import '../../../domain_artist/utils/utils.dart';
import '../../../domain_playlist/entities/entities.dart';
import '../../../domain_playlist/utils/utils.dart';
import '../../../domain_song/entities/entities.dart';
import '../../../domain_song/utils/utils.dart';
import '../../../domain_video/entities/video_short.dart';
import '../../entities/entities.dart';
import '../../model/model.dart';

SectionPlaylist? convertSectionPlaylistFromModel(SectionsModel sectionsModel) {
  if (sectionsModel.sectionType != 'playlist') return null;

  List<MiniPlaylist>? miniPlaylists = (sectionsModel.items as List)
      .map((jsonData) => convertMiniPlaylistFromJson(jsonData)!)
      .toList();

  return SectionPlaylist(
    title: sectionsModel.title,
    items: miniPlaylists,
    total: miniPlaylists.length,
  );
}

SectionArtist? convertSectionArtistFromModel(SectionsModel sectionsModel) {
  if (sectionsModel.sectionType != 'artistSpotlight' &&
      sectionsModel.sectionType != 'artist') return null;

  List<MiniArtist>? miniArtists = (sectionsModel.items as List)
      .map((jsonData) => convertMiniArtistFromJson(jsonData)!)
      .toList();

  return SectionArtist(
    title: sectionsModel.title,
    items: miniArtists,
    total: miniArtists.length,
  );
}

SectionSong? convertSectionSongFromModel(SectionsModel sectionsModel) {
  if (sectionsModel.sectionType != 'song') return null;

  List<SongInfo>? songs = (sectionsModel.items as List)
      .map((jsonData) => convertSongInfoFromJson(jsonData)!)
      .toList();

  return SectionSong(
    title: sectionsModel.title,
    items: songs,
    total: songs.length,
  );
}

SectionVideo? convertSectionVideoFromModel(SectionsModel sectionsModel) {
  if (sectionsModel.sectionType != 'video') return null;

  List<VideoShort>? videos = (sectionsModel.items as List)
      .map((jsonData) => convertVideoShortModel(jsonData))
      .toList();

  return SectionVideo(
    title: sectionsModel.title,
    items: videos,
    total: videos.length,
  );
}

SectionSong combineSectionSong(SectionSong a, SectionSong b, int total) {
  SectionSong c = SectionSong(
    title: a.title ?? b.title,
    items: [...?a.items, ...?b.items],
    total: total,
  );
  return c;
}

SectionArtist combineSectionArtist(
    SectionArtist a, SectionArtist b, int total) {
  SectionArtist c = SectionArtist(
    title: a.title ?? b.title,
    items: [...?a.items, ...?b.items],
    total: total,
  );
  return c;
}

SectionPlaylist combineSectionPlaylist(
    SectionPlaylist a, SectionPlaylist b, int total) {
  SectionPlaylist c = SectionPlaylist(
    title: a.title ?? b.title,
    items: [...?a.items, ...?b.items],
    total: total,
  );
  return c;
}

SectionVideo combineSectionVideo(SectionVideo a, SectionVideo b, int total) {
  SectionVideo c = SectionVideo(
      title: a.title ?? b.title,
      items: [...?a.items, ...?b.items],
      total: total);
  return c;
}
