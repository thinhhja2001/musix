import 'package:musix/domain_global/models/model.dart';

class GetArtistModel {
  int? err;
  String? msg;
  ArtistModel? data;
  int? timestamp;

  GetArtistModel({this.err, this.msg, this.data, this.timestamp});

  GetArtistModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? ArtistModel.fromJson(json['data']) : null;
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

class ArtistModel {
  String? id;
  String? name;
  String? alias;
  String? playlistId;
  String? cover;
  String? thumbnail;
  String? biography;
  String? sortBiography;
  String? thumbnailM;
  String? national;
  String? birthday;
  String? realname;
  List<SectionsModel>? sections;

  ArtistModel({
    this.id,
    this.name,
    this.alias,
    this.playlistId,
    this.cover,
    this.thumbnail,
    this.biography,
    this.sortBiography,
    this.thumbnailM,
    this.national,
    this.birthday,
    this.realname,
    this.sections,
  });

  ArtistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    playlistId = json['playlistId'];
    cover = json['cover'];
    thumbnail = json['thumbnail'];
    biography = json['biography'];
    sortBiography = json['sortBiography'];
    thumbnailM = json['thumbnailM'];
    national = json['national'];
    birthday = json['birthday'];
    realname = json['realname'];
    if (json['sections'] != null) {
      sections = <SectionsModel>[];
      json['sections'].forEach((v) {
        sections!.add(SectionsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['playlistId'] = playlistId;
    data['cover'] = cover;
    data['thumbnail'] = thumbnail;
    data['biography'] = biography;
    data['sortBiography'] = sortBiography;
    data['thumbnailM'] = thumbnailM;
    data['national'] = national;
    data['birthday'] = birthday;
    data['realname'] = realname;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
