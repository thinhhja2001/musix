import 'package:get_it/get_it.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../models/model.dart';

class HubRepo {
  Future<GetHubDetailModel> getHubDetailed(String hubId) async {
    final zingMP3APIV2 = await GetIt.instance.getAsync<ZingMP3APIV2>();
    final response = await zingMP3APIV2.getHubDetailById(hubId);
    return GetHubDetailModel.fromJson(response);
  }
}
