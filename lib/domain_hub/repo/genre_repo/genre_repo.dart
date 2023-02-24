import 'package:musix/domain_hub/model/model.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../../../config/register_dependency.dart';

class GenreRepo {
  Future<GetGerneModel> getGenreById(String id) async {
    final ZingMP3APIV2 zingMP3APIV2 = await getIt.getAsync<ZingMP3APIV2>();
    final response = await zingMP3APIV2.getGenreById(id);
    return GetGerneModel.fromJson(response);
  }
}
