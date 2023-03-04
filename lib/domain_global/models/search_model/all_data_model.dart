import '../../../domain_artist/models/models.dart';
import '../../../domain_playlist/models/playlist/playlist_model.dart';
import '../../../domain_song/models/models.dart';
import '../../../domain_video/models/models.dart';

class AllDataModel {
  List<ArtistModel>? artists;
  List<SongInfoModel>? songs;
  List<PlaylistModel>? playlists;
  List<VideoShortModel>? videos;

  AllDataModel({
    this.artists,
    this.songs,
    this.playlists,
    this.videos,
  });

  AllDataModel.fromJson(Map<String, dynamic> json) {
    if (json['artists'] != null) {
      artists = <ArtistModel>[];
      json['artists'].forEach((v) {
        artists!.add(ArtistModel.fromJson(v));
      });
    }
    if (json['songs'] != null) {
      songs = <SongInfoModel>[];
      json['songs'].forEach((v) {
        songs!.add(SongInfoModel.fromJson(v));
      });
    }
    if (json['playlists'] != null) {
      playlists = <PlaylistModel>[];
      json['playlists'].forEach((v) {
        playlists!.add(PlaylistModel.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <VideoShortModel>[];
      json['videos'].forEach((v) {
        videos!.add(VideoShortModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
