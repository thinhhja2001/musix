import '../models/songs/song_source.dart';

import 'package:zing_mp3_api/zing_mp3_api.dart';

class SongSourceRepositoryImpl {
  Future<SongSource> getInfo(String id) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();
    final sourceJson = await zingMp3Api.getSongById(id);
    final lyricJson = await zingMp3Api.getLyricBySongId(id);
    return SongSource.fromJson(
      sourceJson["data"],
      lyricJson["data"],
    );
  }
}
