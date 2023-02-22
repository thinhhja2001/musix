class ArtistModel {
  String? id;
  String? name;
  String? alias;
  String? thumbnail;
  String? thumbnailM;
  String? playlistId;

  ArtistModel({
    this.id,
    this.name,
    this.alias,
    this.thumbnail,
    this.thumbnailM,
    this.playlistId,
  });

  ArtistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    thumbnail = json['thumbnail'];
    thumbnailM = json['thumbnailM'];
    playlistId = json['playlistId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['thumbnail'] = thumbnail;
    data['thumbnailM'] = thumbnailM;
    data['playlistId'] = playlistId;
    return data;
  }
}
