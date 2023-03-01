import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../config/register_dependency.dart';
import '../../utils/utils.dart';
import '../models/models.dart';
import 'i_playlist_repo.dart';

class PlaylistRepo implements IPlaylistRepo {
  @override
  Future<GetPlaylistModel> getPlaylistById(String id) async {
    final ZingMP3APIV2 zingMP3APIV2 = await getIt.getAsync<ZingMP3APIV2>();
    final response = await zingMP3APIV2.getPlaylistById(id);
    DebugLogger().log(response);
    DebugLogger().log('hello');
    GetPlaylistModel model = GetPlaylistModel.fromJson(response);
    DebugLogger().log(model);
    return model;
  }
}
