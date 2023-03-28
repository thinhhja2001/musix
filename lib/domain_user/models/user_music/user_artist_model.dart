class UserArtistModel {
  String? id;
  String? name;
  String? alias;

  UserArtistModel({this.id, this.name, this.alias});

  UserArtistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    return data;
  }
}
