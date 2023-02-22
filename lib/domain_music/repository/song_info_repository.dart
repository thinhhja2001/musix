import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:musix/config/register_dependency.dart';

import '../models/models.dart';
import 'repository.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

class SongInfoRepositoryImpl implements IRepository<SongInfoModel> {
  @override
  Future<SongInfoModel> getInfo(String id) async {
    final zingMp3Api = await getIt.getAsync<ZingMP3APIV2>();
    final songInfoJson = await zingMp3Api.getSongInfoById(id);
    return SongInfoModel.fromJson(
      songInfoJson["data"],
    );
  }

  @override
  Future<List<SongInfoModel>> getByQuery(String query) async {
    final zingMp3Api = await getIt.getAsync<ZingMP3APIV2>();

    final json = await zingMp3Api.searchMusicByQuery(query);

    final songsInfoJson = json["data"]?["songs"] ?? [];
    return songsInfoJson
        .map(
          (songInfoJson) => SongInfoModel.fromJson(songInfoJson),
        )
        .toList()
        .cast<SongInfoModel>();
  }
}

void printJson(Map<String, dynamic>? json) {
  JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(json);
  print(prettyprint);
}
