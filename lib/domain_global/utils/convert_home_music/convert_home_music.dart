import '../../../domain_hub/entities/entities.dart';
import '../../../domain_hub/model/model.dart';
import '../../../domain_hub/utils/utils.dart';
import '../../entities/entities.dart';
import '../../models/model.dart';

HomeMusic? convertFromGetHomeModel(GetHomeModel model) {
  if (model.data == null) return null;
  HomeMusic homeMusic = const HomeMusic();
  for (int i = 0; i < model.data!.total!; i++) {
    SectionsModel section = model.data!.items![i];
    if (section.sectionType == 'playlist' &&
        section.sectionId == 'hAutoTheme2') {
      SectionPlaylist? sPlaylist = convertSectionPlaylistFromModel(section)!;
      sPlaylist = sPlaylist.copyWith(title: 'Gần đây');
      homeMusic = homeMusic.copyWith(
        newPlaylists: sPlaylist,
      );
      continue;
    }
    if (section.sectionType == 'playlist' && section.sectionId == 'hAlbum') {
      SectionPlaylist sPlaylist = convertSectionPlaylistFromModel(section)!;
      sPlaylist = sPlaylist.copyWith(title: 'Ngẫu nhiên');
      homeMusic = homeMusic.copyWith(
        randomPlaylist: sPlaylist,
      );
      continue;
    }
    if (section.sectionType == 'artistSpotlight') {
      SectionArtist sArtist = convertSectionArtistFromModel(section)!;
      sArtist = sArtist.copyWith(title: 'Nghệ sĩ tuần');
      homeMusic = homeMusic.copyWith(
        representArtists: sArtist,
      );
      continue;
    }
    if (section.sectionType == 'new-release') {
      List<SectionSong> newReleaseSongs =
          convertNewReleaseSongFromJson(section.items! as Map<String, dynamic>);
      homeMusic = homeMusic.copyWith(
        newReleaseSongs: newReleaseSongs,
      );
    }
  }
  return homeMusic;
}
