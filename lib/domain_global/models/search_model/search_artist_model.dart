import '../../../domain_artist/models/models.dart';

class SearchArtistModel {
  int? err;
  String? msg;
  SearchArtistDataModel? data;
  int? timestamp;

  SearchArtistModel({this.err, this.msg, this.data, this.timestamp});

  SearchArtistModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null
        ? SearchArtistDataModel.fromJson(json['data'])
        : null;
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

class SearchArtistDataModel {
  List<ArtistModel>? items;
  int? total;
  String? sectionId;

  SearchArtistDataModel({this.items, this.total, this.sectionId});

  SearchArtistDataModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ArtistModel>[];
      json['items'].forEach((v) {
        items!.add(ArtistModel.fromJson(v));
      });
    }
    total = json['total'];
    sectionId = json['sectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['sectionId'] = sectionId;
    return data;
  }
}
