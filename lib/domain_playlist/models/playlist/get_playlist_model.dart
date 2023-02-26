import 'playlist_model.dart';

import '../models.dart';

class GetPlaylistModel {
  int? err;
  String? msg;
  PlaylistModel? data;
  int? timestamp;

  GetPlaylistModel({this.err, this.msg, this.data, this.timestamp});

  GetPlaylistModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? PlaylistModel.fromJson(json['data']) : null;
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
