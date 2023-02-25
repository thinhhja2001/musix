import '../../../domain_music/entities/song_info.dart';
import '../../../domain_music/models/songs/song_info_model.dart';
import '../../../domain_music/utils/utils.dart';
import '../../../domain_playlist/utils/utils.dart';
import '../../entities/entities.dart';
import '../../model/model.dart';

List<NewReleaseSong> convertNewReleaseSongFromJson(Map<String, dynamic> json) {
  final results = <NewReleaseSong>[];
  if (json['all'] != null) {
    String title = 'All';
    final data = <SongInfo>[];
    json['all'].forEach((v) {
      data.add(convertSongInfoModel(SongInfoModel.fromJson(v))!);
    });
    results.add(NewReleaseSong(title: title, songs: data));
  }
  if (json['vPop'] != null) {
    String title = 'Việt Nam';
    final data = <SongInfo>[];
    json['vPop'].forEach((v) {
      data.add(convertSongInfoModel(SongInfoModel.fromJson(v))!);
    });
    results.add(NewReleaseSong(title: title, songs: data));
  }
  if (json['others'] != null) {
    String title = 'Quốc tế';
    final data = <SongInfo>[];
    json['others'].forEach((v) {
      data.add(convertSongInfoModel(SongInfoModel.fromJson(v))!);
    });
    results.add(NewReleaseSong(title: title, songs: data));
  }
  return results;
}

NewReleaseSong? convertNewReleaseSongModel(
    GetNewReleaseSongModel getNewReleaseSongModel) {
  if (getNewReleaseSongModel.data == null) return null;
  return NewReleaseSong(
      title: 'Tất cả',
      songs: getNewReleaseSongModel.data!
          .map((e) => convertSongInfoModel(e))
          .toList());
}

NewReleasePlaylist? convertNewReleasePlaylistModel(
    GetNewReleasePlaylistModel getNewReleasePlaylistModel) {
  if (getNewReleasePlaylistModel.data == null) return null;
  return NewReleasePlaylist(
      title: 'Tất cả',
      playlists: getNewReleasePlaylistModel.data!
          .map((e) => convertPlaylistModel(e))
          .toList());
}