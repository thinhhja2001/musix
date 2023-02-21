import 'package:musix/config/register_dependency.dart';
import 'package:musix/domain_album/models/models.dart';
import 'package:musix/domain_album/repo/i_playlist_repo.dart';
import 'package:musix/utils/utils.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

class PlaylistRepo implements IPlaylistRepo {
  @override
  Future<GetPlaylistModel> getPlaylistById(String id) async {
    final ZingMP3APIV2 zingMP3APIV2 = await getIt.getAsync<ZingMP3APIV2>();
    final response = await zingMP3APIV2.getPlaylistById(id);
    DebugLogger().log(response);
    return GetPlaylistModel.fromJson(response);
  }

  @override
  Future getGenreById(String id) async {
    final ZingMP3APIV2 zingMP3APIV2 = await getIt.getAsync<ZingMP3APIV2>();
    final response = await zingMP3APIV2.getGenreById(id);
    DebugLogger().log(response);
    return GetGerneModel.fromJson(response);
  }
}
