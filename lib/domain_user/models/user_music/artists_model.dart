import '../models.dart';

class ArtistsModel {
  List<UserPlaylistModel>? artists;

  ArtistsModel({this.artists});

  ArtistsModel.fromJson(Map<String, dynamic> json) {
    if (json['artists'] != null) {
      artists = <UserPlaylistModel>[];
      json['artists'].forEach((v) {
        artists!.add(UserPlaylistModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
