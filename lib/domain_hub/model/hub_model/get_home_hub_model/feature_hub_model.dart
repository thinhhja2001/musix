import '../../model.dart';

class FeaturedHubModel {
  String? title;
  List<HubModel>? items;

  FeaturedHubModel({
    this.title,
    this.items,
  });

  FeaturedHubModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['items'] != null) {
      items = <HubModel>[];
      json['items'].forEach((v) {
        items!.add(HubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
