import '../../global/repo/initial_repo.dart';
import '../models/get_home_model/get_home_model.dart';

class HomeMusicRepo extends InitialRepo {
  Future<GetHomeModel> getHomeModel() async {
    final response = await (await apiZingMP3).getHomeList();
    return GetHomeModel.fromJson(response);
  }
}
