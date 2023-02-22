class GetGerneModel {
  int? err;
  String? msg;
  DataInGetGenresModel? data;
  int? timestamp;

  GetGerneModel({this.err, this.msg, this.data, this.timestamp});

  GetGerneModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null
        ? DataInGetGenresModel.fromJson(json['data'])
        : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['err'] = err;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class DataInGetGenresModel {
  String? id;
  String? name;
  String? title;
  String? alias;
  String? link;
  GenreInGetGenresModel? parent;
  List<GenreInGetGenresModel>? childs;

  DataInGetGenresModel(
      {this.id,
      this.name,
      this.title,
      this.alias,
      this.link,
      this.parent,
      this.childs});

  DataInGetGenresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    alias = json['alias'];
    link = json['link'];
    parent = json['parent'] != null
        ? GenreInGetGenresModel.fromJson(json['parent'])
        : null;
    if (json['childs'] != null) {
      childs = <GenreInGetGenresModel>[];
      json['childs'].forEach((v) {
        childs!.add(GenreInGetGenresModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['alias'] = alias;
    data['link'] = link;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    if (childs != null) {
      data['childs'] = childs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GenreInGetGenresModel {
  String? id;
  String? name;
  String? title;
  String? alias;
  String? link;

  GenreInGetGenresModel(
      {this.id, this.name, this.title, this.alias, this.link});

  GenreInGetGenresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    alias = json['alias'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['alias'] = alias;
    data['link'] = link;
    return data;
  }
}
