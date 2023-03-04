import '../../../domain_playlist/models/playlist/playlist_model.dart';

class SearchPlaylistModel {
  int? err;
  String? msg;
  SearchPlaylistDataModel? data;
  int? timestamp;

  SearchPlaylistModel({this.err, this.msg, this.data, this.timestamp});

  SearchPlaylistModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null
        ? SearchPlaylistDataModel.fromJson(json['data'])
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

class SearchPlaylistDataModel {
  List<PlaylistModel>? items;
  int? total;
  String? sectionId;

  SearchPlaylistDataModel({this.items, this.total, this.sectionId});

  SearchPlaylistDataModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <PlaylistModel>[];
      json['items'].forEach((v) {
        items!.add(PlaylistModel.fromJson(v));
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
