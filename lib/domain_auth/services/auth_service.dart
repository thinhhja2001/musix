import 'package:dio/dio.dart';
import '../payload/request/login_request.dart';
import '../payload/request/register_request.dart';
import '../payload/request/reset_password_request.dart';
import 'i_auth_service.dart';
import '../utils/dio_utils.dart';

import '../../config/exporter/environment_exporter.dart';

class AuthService implements IAuthService {
  final String databaseUrl = Environment.databaseUrl;
  final dio = Dio();
  AuthService() {
    dio.options = BaseOptions(validateStatus: validateStatus);
  }
  @override
  Future<Map<String, dynamic>> login(LoginRequest request) async {
    final url = "$databaseUrl/auth/login";
    late Response response;

    response = await dio.post(
      url,
      data: request.toJson(),
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> register(RegisterRequest request) async {
    final url = "$databaseUrl/auth/register";
    var response = await dio.post(
      url,
      data: request.toJson(),
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> resendVerificationEmail(String username) async {
    final url = "$databaseUrl/auth/resend/$username";
    var response = await dio.post(url);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> sendResetOtp(String email) async {
    final url = "$databaseUrl/auth/reset/$email";
    var response = await dio.post(url);
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> resetPassword(
      ResetPasswordRequest request) async {
    final url = "$databaseUrl/auth/reset";
    var response = await dio.patch(url, data: request.toJson());
    return response.data;
  }
}
