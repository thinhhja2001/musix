import '../model.dart';

class GetHomeModel {
  int? err;
  String? msg;
  HomeDataModel? data;
  int? timestamp;

  GetHomeModel({
    this.err,
    this.msg,
    this.data,
    this.timestamp,
  });

  GetHomeModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
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
