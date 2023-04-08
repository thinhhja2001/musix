import 'package:dio/dio.dart';
import 'package:musix/config/environment.dart';
import 'package:musix/config/register_dependency.dart';
import 'package:musix/domain_auth/utils/dio_utils.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

class InitialRepo {
  final Future<ZingMP3APIV2> apiZingMP3 = getIt.getAsync<ZingMP3APIV2>();
  late final Dio dio;
  final String exception = 'Bad Request';

  InitialRepo() {
    _initDio();
  }

  void _initDio() {
    final options = BaseOptions(
      validateStatus: validateStatus,
      baseUrl: Environment.databaseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(options);
  }

  Map<String, String> headerMultiFormData({required String token}) =>
      <String, String>{
        'Content-Type': 'multipart/form-data',
        'Authorization': "Bearer $token",
      };

  Map<String, String> headerApplicationJson({required String token}) =>
      <String, String>{
        "Content-Type": "application/json",
        'authorization': "Bearer $token",
      };
}
