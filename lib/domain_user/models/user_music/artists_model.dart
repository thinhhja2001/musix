import '../models.dart';

class ArtistsModel {
  List<UserArtistModel>? artists;

  ArtistsModel({this.artists});

  ArtistsModel.fromJson(Map<String, dynamic> json) {
    if (json['artists'] != null) {
      artists = <UserArtistModel>[];
      json['artists'].forEach((v) {
        artists!.add(UserArtistModel.fromJson(v));
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
