import '../../model.dart';

class HubModel {
  String? encodeId;
  String? cover;
  String? thumbnail;
  String? thumbnailHasText;
  String? thumbnailR;
  String? title;
  String? description;
  List<SectionsModel>? sections;

  HubModel({
    this.encodeId,
    this.cover,
    this.thumbnail,
    this.thumbnailHasText,
    this.thumbnailR,
    this.title,
    this.description,
    this.sections,
  });

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
