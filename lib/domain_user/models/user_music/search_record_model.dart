class SearchRecordModel {
  List<String>? searchRecord;

  SearchRecordModel({this.searchRecord});

  SearchRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['searchRecord'] != null) {
      searchRecord = <String>[];
      json['searchRecord'].forEach((v) {
        searchRecord!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (searchRecord != null) {
      data['searchRecord'] = searchRecord!.toList();
    }
    return data;
  }
}
