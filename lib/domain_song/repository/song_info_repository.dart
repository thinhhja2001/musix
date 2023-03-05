import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../config/register_dependency.dart';
import '../models/models.dart';
import 'repository.dart';

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
