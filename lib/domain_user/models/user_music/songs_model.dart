import '../models.dart';

class SongsModel {
  List<UserSongModel>? songs;

  SongsModel({this.songs});

  SongsModel.fromJson(Map<String, dynamic> json) {
    if (json['songs'] != null) {
      songs = <UserSongModel>[];
      json['songs'].forEach((v) {
        songs!.add(UserSongModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
