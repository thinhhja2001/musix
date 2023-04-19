import 'package:dio/dio.dart';

import '../../config/exporter/environment_exporter.dart';
import '../../global/repo/initial_repo.dart';
import '../../utils/utils.dart';
import '../payload/request/login_request.dart';
import '../payload/request/register_request.dart';
import '../payload/request/reset_password_request.dart';
import 'i_auth_service.dart';

class AuthService extends InitialRepo implements IAuthService {
  final String databaseUrl = Environment.databaseUrl;
  AuthService();
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
  Future<bool> logout(String token) async {
    final url = "$databaseUrl/auth/logout";

    try {
      await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return true;
    } on DioError catch (e) {
      DebugLogger().log("Error: ${e.message}");
      return false;
    }
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

  @override
  Future<Map<String, dynamic>> authenticate(String token) async {
    final url = "$databaseUrl/auth/authenticate";
    try {
      var response = await dio.post(
        url,
        data: {"token": token},
      );
      return response.data;
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }
}
