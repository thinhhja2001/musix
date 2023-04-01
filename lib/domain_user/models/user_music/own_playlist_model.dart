import '../models.dart';

class OwnPlaylistModel {
  String? id;
  String? title;
  String? thumbnail;
  String? releasedAt;
  String? sortDescription;
  List<UserSongModel>? songs;
  int? countSongs;
  String? type;

  OwnPlaylistModel(
      {this.id,
      this.title,
      this.thumbnail,
      this.releasedAt,
      this.sortDescription,
      this.songs,
      this.countSongs,
      this.type});

  OwnPlaylistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    releasedAt = json['releasedAt'];
    sortDescription = json['sortDescription'];
    if (json['songs'] != null) {
      songs = <UserSongModel>[];
      json['songs'].forEach((v) {
        songs!.add(UserSongModel.fromJson(v));
      });
    }
    countSongs = json['countSongs'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['releasedAt'] = releasedAt;
    data['sortDescription'] = sortDescription;
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    data['countSongs'] = countSongs;
    data['type'] = type;
    return data;
  }
}
