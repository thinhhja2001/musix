import '../../model.dart';

class GetHubDetailModel {
  int? err;
  String? msg;
  HubModel? data;
  int? timestamp;

  GetHubDetailModel({this.err, this.msg, this.data, this.timestamp});

  GetHubDetailModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? HubModel.fromJson(json['data']) : null;
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
