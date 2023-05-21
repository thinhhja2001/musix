class SongRecordModel {
  List<String>? songRecord;

  SongRecordModel({this.songRecord});

  SongRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['songRecord'] != null) {
      songRecord = <String>[];
      json['songRecord'].forEach((v) {
        songRecord!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (songRecord != null) {
      data['songRecord'] = songRecord!.toList();
    }
    return data;
  }
}
