import '../models.dart';

class UserRecordModel {
  RecordModel? record;

  UserRecordModel({this.record});

  UserRecordModel.fromJson(Map<String, dynamic> json) {
    record =
        json['record'] != null ? RecordModel.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (record != null) {
      data['record'] = record!.toJson();
    }
    return data;
  }
}
