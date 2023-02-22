import 'i_repository.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../models/models.dart';

class VideoRepositoryImpl extends IRepository {
  @override
  Future<VideoDetail> getInfo(String id) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();
    final json = await zingMp3Api.getVideoById(id);
    // printJson(json);
    return VideoDetail.fromJson(json["data"]);
  }

  @override
  Future<List<VideoShort>> getByQuery(String query) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();
    final json = await zingMp3Api.searchMusicByQuery(query);
    final videosInfoJson = json["data"]?["videos"] ?? [];
    // print(videosInfoJson);
    // for (var video in videos) {

    // }
    return videosInfoJson
        .map(
          (videoInfoJson) => VideoShort.fromJson(videoInfoJson),
        )
        .toList()
        .cast<VideoShort>();
  }
}
