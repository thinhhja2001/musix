import '../../../domain_hub/entities/entities.dart';
import '../../../domain_hub/model/model.dart';
import '../../../domain_hub/utils/utils.dart';
import '../../entities/entities.dart';
import '../../models/model.dart';

HomeMusic? convertFromGetHomeModel(GetHomeModel model) {
  if (model.data == null) return null;
  HomeMusic homeMusic = const HomeMusic(
    sectionPlaylists: [],
    newReleaseSongs: [],
  );
  List<SectionPlaylist> sectionPlaylists = [];
  for (int i = 0; i < model.data!.items!.length; i++) {
    SectionsModel section = model.data!.items![i];
    if (section.sectionType == 'playlist') {
      if (section.items != null) {
        SectionPlaylist? sPlaylist = convertSectionPlaylistFromModel(section)!;
        sectionPlaylists.add(sPlaylist);
      }
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
  homeMusic = homeMusic.copyWith(sectionPlaylists: sectionPlaylists);
  return homeMusic;
}
