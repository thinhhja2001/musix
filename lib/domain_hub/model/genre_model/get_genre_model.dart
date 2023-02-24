import '../model.dart';

class GetGerneModel {
  int? err;
  String? msg;
  GenresModel? data;
  int? timestamp;

  GetGerneModel({
    this.err,
    this.msg,
    this.data,
    this.timestamp,
  });

  GetGerneModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? GenresModel.fromJson(json['data']) : null;
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
