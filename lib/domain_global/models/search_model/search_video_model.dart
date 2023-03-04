import '../../../domain_video/models/models.dart';

class SearchVideoModel {
  int? err;
  String? msg;
  SearchVideoDataModel? data;
  int? timestamp;

  SearchVideoModel({this.err, this.msg, this.data, this.timestamp});

  SearchVideoModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null
        ? SearchVideoDataModel.fromJson(json['data'])
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

class SearchVideoDataModel {
  List<VideoShortModel>? items;
  int? total;
  String? sectionId;

  SearchVideoDataModel({this.items, this.total, this.sectionId});

  SearchVideoDataModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <VideoShortModel>[];
      json['items'].forEach((v) {
        items!.add(VideoShortModel.fromJson(v));
      });
    }
    total = json['total'];
    sectionId = json['sectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['sectionId'] = sectionId;
    return data;
  }
}
