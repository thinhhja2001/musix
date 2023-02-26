import '../../../domain_hub/model/model.dart';

class HomeDataModel {
  List<SectionsModel>? items;
  bool? hasMore;
  int? total;

  HomeDataModel({
    this.items,
    this.hasMore,
    this.total,
  });

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <SectionsModel>[];
      json['items'].forEach((v) {
        items!.add(SectionsModel.fromJson(v));
      });
    }
    hasMore = json['hasMore'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['hasMore'] = hasMore;
    data['total'] = total;
    return data;
  }
}
