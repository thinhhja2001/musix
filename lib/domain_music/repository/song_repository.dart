import 'dart:convert';

import 'package:musix/domain_music/models/models.dart';
import 'package:musix/domain_music/repository/i_repository.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

class SongRepositoryImpl implements IRepository {
  @override
  Future<Song> getInfo(String id) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();
    final songInfoJson = await zingMp3Api.getSongInfoById(id);
    final lyricJson = await zingMp3Api.getLyricBySongId(id);
    final audioJson = await zingMp3Api.getSongById(id);
    // printJson(songInfoJson);
    return Song.fromJson(
      songInfoJson["data"],
      lyricJson["data"],
      audioJson["data"],
    );
  }
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
