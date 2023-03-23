import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  String? loginMsg;
  String? registerMsg;
  String? resendEmailMsg;
  int? loginStatus;
  int? registerStatus;
  int? resendEmailStatus;
  bool? isLoginLoading;
  bool? isRegisterLoading;
  bool? isResendEmailLoading;
  AuthState({
    this.loginMsg,
    this.registerMsg,
    this.resendEmailMsg,
    this.loginStatus,
    this.registerStatus,
    this.resendEmailStatus,
    this.isLoginLoading,
    this.isRegisterLoading,
    this.isResendEmailLoading,
  });
  AuthState copyWith(
          {String? loginMsg,
          String? registerMsg,
          String? resendEmailMsg,
          int? loginStatus,
          int? registerStatus,
          int? resendEmailStatus,
          bool? isLoginLoading,
          bool? isRegisterLoading,
          bool? isResendEmailLoading}) =>
      AuthState(
        loginMsg: loginMsg ?? this.loginMsg,
        registerMsg: registerMsg ?? this.registerMsg,
        resendEmailMsg: resendEmailMsg ?? this.resendEmailMsg,
        loginStatus: loginStatus ?? this.loginStatus,
        registerStatus: registerStatus ?? this.registerStatus,
        resendEmailStatus: resendEmailStatus ?? this.resendEmailStatus,
        isLoginLoading: isLoginLoading ?? this.isLoginLoading,
        isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
        isResendEmailLoading: isResendEmailLoading ?? this.isResendEmailLoading,
      );

  @override
  List<Object?> get props => [
        loginMsg,
        registerMsg,
        resendEmailMsg,
        loginStatus,
        registerStatus,
        resendEmailStatus,
        isLoginLoading,
        isRegisterLoading,
        isResendEmailLoading,
      ];

  @override
  bool? get stringify => true;
}
