import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../config/register_dependency.dart';
import '../models/songs/song_source_model.dart';

class SongSourceRepositoryImpl {
  Future<SongSourceModel> getInfo(String id) async {
    final zingMp3Api = await getIt.getAsync<ZingMP3APIV2>();

    final sourceJson = await zingMp3Api.getSongById(id);
    final lyricJson = await zingMp3Api.getLyricBySongId(id);
    return SongSourceModel.fromJson(
      sourceJson["data"],
      lyricJson["data"],
    );
  }
}
