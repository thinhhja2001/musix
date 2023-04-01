class UserSongModel {
  String? id;
  String? title;
  String? artistNames;
  String? genreNames;

  UserSongModel({this.id, this.title, this.artistNames, this.genreNames});

  UserSongModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    artistNames = json['artistNames'];
    genreNames = json['genreNames'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['artistNames'] = artistNames;
    data['genreNames'] = genreNames;
    return data;
  }
}
