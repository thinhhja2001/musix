import 'package:musix/domain_auth/payload/response/i_response.dart';

class LoginResponse extends IResponse {
  LoginResponse({required super.status, required super.msg, super.data});
}
