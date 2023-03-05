import '../model.dart';

class SearchAllModel {
  int? err;
  String? msg;
  AllDataModel? data;
  int? timestamp;

  SearchAllModel({this.err, this.msg, this.data, this.timestamp});

  SearchAllModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? AllDataModel.fromJson(json['data']) : null;
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
