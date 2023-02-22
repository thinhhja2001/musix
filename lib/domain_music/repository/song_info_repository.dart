import 'dart:convert';

import '../models/models.dart';
import 'repository.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

class SongInfoRepositoryImpl implements IRepository<SongInfo> {
  @override
  Future<SongInfo> getInfo(String id) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();
    final songInfoJson = await zingMp3Api.getSongInfoById(id);
    return SongInfo.fromJson(
      songInfoJson["data"],
    );
  }

  @override
  Future<List<SongInfo>> getByQuery(String query) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();

    final json = await zingMp3Api.searchMusicByQuery(query);

    final songsInfoJson = json["data"]?["songs"] ?? [];
    return songsInfoJson
        .map(
          (songInfoJson) => SongInfo.fromJson(songInfoJson),
        )
        .toList()
        .cast<SongInfo>();
  }
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
