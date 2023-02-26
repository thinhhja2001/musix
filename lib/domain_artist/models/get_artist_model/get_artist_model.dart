import '../../../domain_global/models/model.dart';
import '../models.dart';

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
