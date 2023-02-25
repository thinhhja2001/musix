import '../../model.dart';

class HomeHubModel {
  FeaturedHubModel? featured;
  List<HubModel>? topTopic;
  List<HubModel>? topic;
  List<HubModel>? nations;
  List<HubModel>? genre;

  HomeHubModel({
    this.featured,
    this.topTopic,
    this.topic,
    this.nations,
    this.genre,
  });

  HomeHubModel.fromJson(Map<String, dynamic> json) {
    featured = json['featured'] != null
        ? FeaturedHubModel.fromJson(json['featured'])
        : null;
    if (json['topTopic'] != null) {
      topTopic = <HubModel>[];
      json['topTopic'].forEach((v) {
        topTopic!.add(HubModel.fromJson(v));
      });
    }
    if (json['topic'] != null) {
      topic = <HubModel>[];
      json['topic'].forEach((v) {
        topic!.add(HubModel.fromJson(v));
      });
    }
    if (json['nations'] != null) {
      nations = <HubModel>[];
      json['nations'].forEach((v) {
        nations!.add(HubModel.fromJson(v));
      });
    }
    if (json['genre'] != null) {
      genre = <HubModel>[];
      json['genre'].forEach((v) {
        genre!.add(HubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (featured != null) {
      data['featured'] = featured!.toJson();
    }
    if (topTopic != null) {
      data['topTopic'] = topTopic!.map((v) => v.toJson()).toList();
    }
    if (topic != null) {
      data['section'] = topic!.map((v) => v.toJson()).toList();
    }
    if (nations != null) {
      data['nations'] = nations!.map((v) => v.toJson()).toList();
    }
    if (genre != null) {
      data['genre'] = genre!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
