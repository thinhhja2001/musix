import '../payload/request/login_request.dart';
import '../payload/request/register_request.dart';

abstract class IAuthService {
  Future<Map<String, dynamic>> login(LoginRequest request);
  Future<Map<String, dynamic>> register(RegisterRequest request);
}
