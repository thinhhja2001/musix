import 'package:musix/config/register_dependency.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

class InitialRepo {
  final Future<ZingMP3APIV2> apiZingMP3 = getIt.getAsync<ZingMP3APIV2>();
}
