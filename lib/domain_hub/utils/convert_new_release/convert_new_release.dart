import '../../../domain_music/entities/song_info.dart';
import '../../../domain_music/models/songs/song_info_model.dart';
import '../../../domain_music/utils/utils.dart';
import '../../../domain_playlist/utils/utils.dart';
import '../../entities/entities.dart';
import '../../model/model.dart';

List<SectionSong> convertNewReleaseSongFromJson(Map<String, dynamic> json) {
  final results = <SectionSong>[];
  if (json['all'] != null) {
    String title = 'All';
    final data = <SongInfo>[];
    json['all'].forEach((v) {
      data.add(convertSongInfoModel(SongInfoModel.fromJson(v))!);
    });
    results.add(SectionSong(title: title, items: data));
  }
  if (json['vPop'] != null) {
    String title = 'Việt Nam';
    final data = <SongInfo>[];
    json['vPop'].forEach((v) {
      data.add(convertSongInfoModel(SongInfoModel.fromJson(v))!);
    });
    results.add(SectionSong(title: title, items: data));
  }
  if (json['others'] != null) {
    String title = 'Quốc tế';
    final data = <SongInfo>[];
    json['others'].forEach((v) {
      data.add(convertSongInfoModel(SongInfoModel.fromJson(v))!);
    });
    results.add(SectionSong(title: title, items: data));
  }
  return results;
}

SectionSong? convertNewReleaseSongModel(
    GetNewReleaseSongModel getNewReleaseSongModel) {
  if (getNewReleaseSongModel.data == null) return null;
  return SectionSong(
      title: 'Tất cả',
      items: getNewReleaseSongModel.data!
          .map((e) => convertSongInfoModel(e)!)
          .toList());
}

SectionPlaylist? convertNewReleasePlaylistModel(
    GetNewReleasePlaylistModel getNewReleasePlaylistModel) {
  if (getNewReleasePlaylistModel.data == null) return null;
  return SectionPlaylist(
      title: 'Tất cả',
      items: getNewReleasePlaylistModel.data!
          .map((e) => convertMiniPlaylistFromPlaylistModel(e)!)
          .toList());
}
