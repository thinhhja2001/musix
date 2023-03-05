import '../../../domain_song/models/models.dart';

class SearchSongModel {
  int? err;
  String? msg;
  SearchSongDataModel? data;
  int? timestamp;

  SearchSongModel({this.err, this.msg, this.data, this.timestamp});

  SearchSongModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null
        ? SearchSongDataModel.fromJson(json['data'])
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

class SearchSongDataModel {
  List<SongInfoModel>? items;
  int? total;
  String? sectionId;

  SearchSongDataModel({this.items, this.total, this.sectionId});

  SearchSongDataModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <SongInfoModel>[];
      json['items'].forEach((v) {
        items!.add(SongInfoModel.fromJson(v));
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
