import '../payload/request/login_request.dart';
import '../payload/request/register_request.dart';
import '../payload/request/reset_password_request.dart';

abstract class IAuthService {
  Future<Map<String, dynamic>> login(LoginRequest request);
  Future<bool> logout(String token);
  Future<Map<String, dynamic>> register(RegisterRequest request);
  Future<Map<String, dynamic>> resendVerificationEmail(String username);
  Future<Map<String, dynamic>> sendResetOtp(String email);
  Future<Map<String, dynamic>> resetPassword(ResetPasswordRequest request);
  Future<Map<String, dynamic>> authenticate(String token);
}
