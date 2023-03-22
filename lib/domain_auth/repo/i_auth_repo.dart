import 'package:http/http.dart';
import 'package:musix/domain_user/models/user.dart';
import 'package:musix/domain_auth/payload/request/login_request.dart';
import 'package:musix/domain_auth/payload/request/register_request.dart';
import 'package:musix/domain_auth/payload/response/i_response.dart';

abstract class IAuthRepo {
  Future<IResponse> login(LoginRequest request);
  Future<IResponse> register(RegisterRequest request);
}
