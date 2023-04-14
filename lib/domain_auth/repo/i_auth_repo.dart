import '../payload/request/login_request.dart';
import '../payload/request/register_request.dart';
import '../payload/request/reset_password_request.dart';

abstract class IAuthRepo<T> {
  Future<T> login(LoginRequest request);
  Future<T> register(RegisterRequest request);
  Future<T> resendVerificationEmail(String username);
  Future<T> requestResetOtp(String email);
  Future<T> resetPassword(ResetPasswordRequest request);
}
