class UserPlaylistModel {
  String? id;
  String? title;
  String? artistNames;
  int? countSongs;
  String? type;

  UserPlaylistModel(
      {this.id, this.title, this.artistNames, this.countSongs, this.type});

  UserPlaylistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    artistNames = json['artistNames'];
    countSongs = json['countSongs'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['artistNames'] = artistNames;
    data['countSongs'] = countSongs;
    data['type'] = type;
    return data;
  }
}
