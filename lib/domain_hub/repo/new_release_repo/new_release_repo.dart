import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../../config/register_dependency.dart';
import '../../../utils/utils.dart';
import '../../model/model.dart';

class NewReleaseRepo {
  Future<dynamic> getNewReleaseList(MusicType type) async {
    final ZingMP3APIV2 zingMP3APIV2 = await getIt.getAsync<ZingMP3APIV2>();
    switch (type) {
      case MusicType.album:
        final response =
            await zingMP3APIV2.getNewReleaseType(ReleaseType.album);
        return GetNewReleasePlaylistModel.fromJson(response);
      case MusicType.song:
        final response = await zingMP3APIV2.getNewReleaseType(ReleaseType.song);
        return GetNewReleaseSongModel.fromJson(response);
    }
  }
}
