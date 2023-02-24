import 'package:get_it/get_it.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../models/get_home_model/get_home_model.dart';

class HomeMusicRepo {
  Future<GetHomeModel> getHomeModel() async {
    final zingMP3APIV2 = await GetIt.instance.getAsync<ZingMP3APIV2>();
    final response = await zingMP3APIV2.getHomeList();
    return GetHomeModel.fromJson(response);
  }
}
