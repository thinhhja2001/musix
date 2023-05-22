class RecordModel {
  List<String>? searchRecord;
  List<String>? songRecord;

  RecordModel({this.searchRecord, this.songRecord});

  RecordModel.fromJson(Map<String, dynamic> json) {
    if (json['songRecord'] != null) {
      songRecord = <String>[];
      json['songRecord'].forEach((v) {
        songRecord!.add(v);
      });
    }
    if (json['searchRecord'] != null) {
      searchRecord = <String>[];
      json['searchRecord'].forEach((v) {
        searchRecord!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (songRecord != null) {
      data['songRecord'] = songRecord;
    }
    if (searchRecord != null) {
      data['searchRecord'] = searchRecord;
    }
    return data;
  }
}
