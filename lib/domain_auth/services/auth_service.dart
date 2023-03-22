import 'package:dio/dio.dart';
import 'package:musix/domain_auth/payload/request/login_request.dart';
import 'package:musix/domain_auth/payload/request/register_request.dart';
import 'package:musix/domain_auth/services/i_auth_service.dart';
import 'package:musix/domain_auth/utils/dio_utils.dart';

import '../../config/exporter/environment_exporter.dart';

class AuthService implements IAuthService {
  final String databaseUrl = Environment.databaseUrl;
  final dio = Dio();

  @override
  Future<Map<String, dynamic>> login(LoginRequest request) async {
    final url = "$databaseUrl/auth/login";
    late Response response;

    response = await dio.post(
      url,
      data: request.toJson(),
      options: Options(validateStatus: validateStatus),
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> register(RegisterRequest request) async {
    final url = "$databaseUrl/auth/register";
    var response = await dio.post(
      url,
      data: request.toJson(),
      options: Options(
        validateStatus: validateStatus,
      ),
    );
    return response.data;
  }
}
