import '../payload/request/login_request.dart';
import '../payload/request/register_request.dart';
import '../payload/request/reset_password_request.dart';
import '../payload/response/i_response.dart';
import '../payload/response/login_response.dart';
import '../payload/response/register_response.dart';
import '../payload/response/request_reset_response.dart';
import '../payload/response/resend_email_response.dart';
import '../payload/response/reset_response.dart';
import '../services/auth_service.dart';
import '../services/i_auth_service.dart';
import 'i_auth_repo.dart';

class AuthRepo implements IAuthRepo<IResponse> {
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
  Future<bool> logout(String token) async {
    final response = await authService.logout(token);
    return response;
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await authService.register(request);
    return RegisterResponse(
        status: response['status'],
        msg: response['msg'],
        data: response['data']);
  }

  @override
  Future<ResendEmailResponse> resendVerificationEmail(String username) async {
    final response = await authService.resendVerificationEmail(username);
    return ResendEmailResponse(
        status: response['status'],
        msg: response['msg'],
        data: response['data']);
  }

  @override
  Future<RequestResetResponse> requestResetOtp(String email) async {
    final response = await authService.sendResetOtp(email);
    return RequestResetResponse(
        status: response['status'],
        msg: response['msg'],
        data: response['data']);
  }

  @override
  Future<ResetResponse> resetPassword(ResetPasswordRequest request) async {
    final response = await authService.resetPassword(request);
    return ResetResponse(
        status: response['status'],
        msg: response['msg'],
        data: response['data']);
  }

  @override
  Future<LoginResponse> authenticate(String token) async {
    final response = await authService.authenticate(token);
    return LoginResponse(
        status: response['status'],
        msg: response['msg'],
        data: response['data']);
  }
}
