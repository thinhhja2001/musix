import '../models.dart';

class PlaylistsModel {
  List<UserPlaylistModel>? playlists;

  PlaylistsModel({this.playlists});

  PlaylistsModel.fromJson(Map<String, dynamic> json) {
    if (json['playlists'] != null) {
      playlists = <UserPlaylistModel>[];
      json['playlists'].forEach((v) {
        playlists!.add(UserPlaylistModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (playlists != null) {
      data['playlists'] = playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
