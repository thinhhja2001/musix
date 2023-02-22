class GetArtistModel {
  int? err;
  String? msg;
  DataInGetArtistModel? data;
  int? timestamp;

  GetArtistModel({this.err, this.msg, this.data, this.timestamp});

  GetArtistModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null
        ? DataInGetArtistModel.fromJson(json['data'])
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

class DataInGetArtistModel {
  String? id;
  String? name;
  String? link;
  bool? spotlight;
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
  int? totalFollow;
  int? follow;
  List<String>? awards;
  String? oalink;
  int? oaid;
  List<SectionsInGetArtistModel>? sections;
  String? sectionId;

  DataInGetArtistModel(
      {this.id,
      this.name,
      this.link,
      this.spotlight,
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
      this.totalFollow,
      this.follow,
      this.awards,
      this.oalink,
      this.oaid,
      this.sections,
      this.sectionId});

  DataInGetArtistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    spotlight = json['spotlight'];
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
    totalFollow = json['totalFollow'];
    follow = json['follow'];
    awards = json['awards'].cast<String>();
    oalink = json['oalink'];
    oaid = json['oaid'];
    if (json['sections'] != null) {
      sections = <SectionsInGetArtistModel>[];
      json['sections'].forEach((v) {
        sections!.add(SectionsInGetArtistModel.fromJson(v));
      });
    }
    sectionId = json['sectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['spotlight'] = spotlight;
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
    data['totalFollow'] = totalFollow;
    data['follow'] = follow;
    data['awards'] = awards;
    data['oalink'] = oalink;
    data['oaid'] = oaid;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    data['sectionId'] = sectionId;
    return data;
  }
}

class SectionsInGetArtistModel {
  String? sectionType;
  String? viewType;
  String? title;
  String? link;
  String? sectionId;
  List<Map<String, dynamic>>? items;
  String? itemType;

  SectionsInGetArtistModel(
      {this.sectionType,
      this.viewType,
      this.title,
      this.link,
      this.sectionId,
      this.items,
      this.itemType});

  SectionsInGetArtistModel.fromJson(Map<String, dynamic> json) {
    sectionType = json['sectionType'];
    viewType = json['viewType'];
    title = json['title'];
    link = json['link'];
    sectionId = json['sectionId'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(v);
      });
    }
    itemType = json['itemType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sectionType'] = sectionType;
    data['viewType'] = viewType;
    data['title'] = title;
    data['link'] = link;
    data['sectionId'] = sectionId;
    if (items != null) {
      data['items'] = items;
    }
    data['itemType'] = itemType;
    return data;
  }
}
