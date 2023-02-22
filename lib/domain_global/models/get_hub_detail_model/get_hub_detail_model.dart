class GetHubDetailModel {
  int? err;
  String? msg;
  HubModel? data;
  int? timestamp;

  GetHubDetailModel({this.err, this.msg, this.data, this.timestamp});

  GetHubDetailModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? HubModel.fromJson(json['data']) : null;
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

class HubModel {
  String? encodeId;
  String? cover;
  String? thumbnail;
  String? thumbnailHasText;
  String? thumbnailR;
  String? title;
  String? description;
  List<SectionsModel>? sections;

  HubModel(
      {this.encodeId,
      this.cover,
      this.thumbnail,
      this.thumbnailHasText,
      this.thumbnailR,
      this.title,
      this.description,
      this.sections});

  HubModel.fromJson(Map<String, dynamic> json) {
    encodeId = json['encodeId'];
    cover = json['cover'];
    thumbnail = json['thumbnail'];
    thumbnailHasText = json['thumbnailHasText'];
    thumbnailR = json['thumbnailR'];
    title = json['title'];
    description = json['description'];
    if (json['sections'] != null) {
      sections = <SectionsModel>[];
      json['sections'].forEach((v) {
        sections!.add(SectionsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encodeId'] = encodeId;
    data['cover'] = cover;
    data['thumbnail'] = thumbnail;
    data['thumbnailHasText'] = thumbnailHasText;
    data['thumbnailR'] = thumbnailR;
    data['title'] = title;
    data['description'] = description;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionsModel {
  String? sectionType;
  String? viewType;
  String? title;
  String? sectionId;
  List<Map<String, dynamic>>? items;

  SectionsModel(
      {this.sectionType,
      this.viewType,
      this.title,
      this.sectionId,
      this.items});

  SectionsModel.fromJson(Map<String, dynamic> json) {
    sectionType = json['sectionType'];
    viewType = json['viewType'];
    title = json['title'];
    sectionId = json['sectionId'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sectionType'] = sectionType;
    data['viewType'] = viewType;
    data['title'] = title;
    data['sectionId'] = sectionId;
    if (items != null) {
      data['items'] = items!;
    }
    return data;
  }
}
