import 'package:musix/domain_auth/payload/request/login_request.dart';
import 'package:musix/domain_auth/payload/request/register_request.dart';

abstract class IAuthRepo<T> {
  Future<T> login(LoginRequest request);
  Future<T> register(RegisterRequest request);
  Future<T> resendVerificationEmail(String username);
}
