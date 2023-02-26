import '../../../domain_song/models/models.dart';

class GetNewReleaseSongModel {
  int? err;
  String? msg;
  List<SongInfoModel>? data;
  int? timestamp;

  GetNewReleaseSongModel({this.err, this.msg, this.data, this.timestamp});

  GetNewReleaseSongModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SongInfoModel>[];
      json['data'].forEach((v) {
        data!.add(SongInfoModel.fromJson(v));
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
