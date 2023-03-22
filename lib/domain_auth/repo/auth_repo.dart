import 'package:musix/domain_user/models/user.dart';
import 'package:musix/domain_auth/payload/request/register_request.dart';
import 'package:musix/domain_auth/payload/request/login_request.dart';
import 'package:musix/domain_auth/payload/response/i_response.dart';
import 'package:musix/domain_auth/payload/response/login_response.dart';
import 'package:musix/domain_auth/payload/response/register_response.dart';
import 'package:musix/domain_auth/repo/i_auth_repo.dart';
import 'package:musix/domain_auth/services/auth_service.dart';
import 'package:musix/domain_auth/services/i_auth_service.dart';

class AuthRepo implements IAuthRepo {
  IAuthService authService = AuthService();
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await authService.login(request);
    return LoginResponse(
        status: response['status'],
        msg: response['msg'],
        data: response['data']);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await authService.register(request);
    return RegisterResponse(
        status: response['status'],
        msg: response['msg'],
        data: response['data']);
  }
}
