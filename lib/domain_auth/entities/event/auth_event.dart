// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:musix/domain_auth/payload/request/login_request.dart';
import 'package:musix/domain_auth/payload/request/register_request.dart';
import 'package:musix/domain_auth/payload/request/reset_password_request.dart';

class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  LoginRequest request;
  AuthLoginEvent(this.request);
}

class AuthRegisterEvent extends AuthEvent {
  RegisterRequest request;
  AuthRegisterEvent(this.request);
}

class AuthResendVerificationEmailEvent extends AuthEvent {
  String username;
  AuthResendVerificationEmailEvent(this.username);
}

class AuthRequestResetPasswordEvent extends AuthEvent {
  String email;
  AuthRequestResetPasswordEvent(this.email);
}

class AuthResetPasswordEvent extends AuthEvent {
  ResetPasswordRequest request;
  AuthResetPasswordEvent(this.request);
}

class AuthResetPasswordScreenBackEvent extends AuthEvent {}

class AuthResetCurrentRequestPasswordStateEvent extends AuthEvent {}

class AuthAutoLoginEvent implements AuthEvent {
  final String token;
  final String username;
  const AuthAutoLoginEvent(this.token, this.username);
}

class AuthLogoutEvent implements AuthEvent {
  const AuthLogoutEvent();
}
