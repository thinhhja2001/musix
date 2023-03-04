import 'package:musix/domain_video/utils/convert_video.dart';

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
  );
}

SectionVideo? convertSectionVideoFromModel(SectionsModel sectionsModel) {
  if (sectionsModel.sectionType != 'song') return null;

  List<VideoShort>? songs = (sectionsModel.items as List)
      .map((jsonData) => convertVideoShortModel(jsonData))
      .toList();

  return SectionVideo(
    title: sectionsModel.title,
    items: songs,
  );
}
