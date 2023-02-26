import '../../../domain_playlist/models/playlist/playlist_model.dart';

import '../../../domain_playlist/models/models.dart';

class GetNewReleasePlaylistModel {
  int? err;
  String? msg;
  List<PlaylistModel>? data;
  int? timestamp;

  GetNewReleasePlaylistModel({this.err, this.msg, this.data, this.timestamp});

  GetNewReleasePlaylistModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PlaylistModel>[];
      json['data'].forEach((v) {
        data!.add(PlaylistModel.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['err'] = err;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((e) => e.toJson()).toList();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}
