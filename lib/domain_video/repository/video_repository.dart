import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../domain_song/repository/i_repository.dart';
import '../models/models.dart';

class VideoRepositoryImpl extends IRepository {
  @override
  Future<VideoDetailModel> getInfo(String id) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();
    final json = await zingMp3Api.getVideoById(id);
    // printJson(json);
    return VideoDetailModel.fromJson(json["data"]);
  }

  @override
  Future<List<VideoShortModel>> getByQuery(String query) async {
    final zingMp3Api = await ZingMP3APIV2.createAsync();
    final json = await zingMp3Api.searchMusicByQuery(query);
    final videosInfoJson = json["data"]?["videos"] ?? [];
    // print(videosInfoJson);
    // for (var video in videos) {

    // }
    return videosInfoJson
        .map(
          (videoInfoJson) => VideoShortModel.fromJson(videoInfoJson),
        )
        .toList()
        .cast<VideoShortModel>();
  }
}
