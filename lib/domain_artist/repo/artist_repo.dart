import 'package:musix/domain_artist/models/get_artist_model/get_artist_model.dart';
import 'package:musix/domain_artist/repo/i_artist_repo.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../config/register_dependency.dart';
import '../../utils/debug/logger.dart';

class ArtistRepo implements IArtistRepo {
  @override
  Future<GetArtistModel> getArtistInfo(String alias) async {
    final ZingMP3APIV2 zingMP3APIV2 = await getIt.getAsync<ZingMP3APIV2>();
    final response = await zingMP3APIV2.getArtistByAlias(alias);
    DebugLogger().log(response);
    return GetArtistModel.fromJson(response);
  }
}
