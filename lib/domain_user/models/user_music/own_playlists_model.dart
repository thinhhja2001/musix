import '../models.dart';

class OwnPlaylistsModel {
  List<OwnPlaylistModel>? playlists;

  OwnPlaylistsModel({this.playlists});

  OwnPlaylistsModel.fromJson(Map<String, dynamic> json) {
    if (json['playlists'] != null) {
      playlists = <OwnPlaylistModel>[];
      json['playlists'].forEach((v) {
        playlists!.add(OwnPlaylistModel.fromJson(v));
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
