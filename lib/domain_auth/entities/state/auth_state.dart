import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AuthState extends Equatable {
  String? loginMsg;
  String? registerMsg;
  String? resendEmailMsg;
  String? requestResetMsg;
  String? resetMsg;
  int? loginStatus;
  int? registerStatus;
  int? resendEmailStatus;
  int? resetStatus;
  int? requestResetStatus;
  bool? isLoginLoading;
  bool? isRegisterLoading;
  bool? isResendEmailLoading;
  bool? isRequestResetLoading;
  bool? isResetLoading;
  AuthState({
    this.loginMsg,
    this.registerMsg,
    this.resendEmailMsg,
    this.requestResetMsg,
    this.resetMsg,
    this.loginStatus,
    this.registerStatus,
    this.resendEmailStatus,
    this.requestResetStatus,
    this.resetStatus,
    this.isLoginLoading,
    this.isRegisterLoading,
    this.isResendEmailLoading,
    this.isRequestResetLoading,
    this.isResetLoading,
  });
  AuthState copyWith({
    String? loginMsg,
    String? registerMsg,
    String? resendEmailMsg,
    String? requestResetMsg,
    String? resetMsg,
    int? loginStatus,
    int? registerStatus,
    int? resendEmailStatus,
    int? requestResetStatus,
    int? resetStatus,
    bool? isLoginLoading,
    bool? isRegisterLoading,
    bool? isResendEmailLoading,
    bool? isRequestResetLoading,
    bool? isResetLoading,
  }) =>
      AuthState(
        loginMsg: loginMsg ?? this.loginMsg,
        registerMsg: registerMsg ?? this.registerMsg,
        resendEmailMsg: resendEmailMsg ?? this.resendEmailMsg,
        requestResetMsg: requestResetMsg ?? this.requestResetMsg,
        resetMsg: resetMsg ?? this.resetMsg,
        loginStatus: loginStatus ?? this.loginStatus,
        registerStatus: registerStatus ?? this.registerStatus,
        resendEmailStatus: resendEmailStatus ?? this.resendEmailStatus,
        requestResetStatus: requestResetStatus ?? this.requestResetStatus,
        resetStatus: resetStatus ?? this.resetStatus,
        isLoginLoading: isLoginLoading ?? this.isLoginLoading,
        isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
        isResendEmailLoading: isResendEmailLoading ?? this.isResendEmailLoading,
        isRequestResetLoading:
            isRequestResetLoading ?? this.isRequestResetLoading,
        isResetLoading: isResetLoading ?? this.isResetLoading,
      );

  @override
  List<Object?> get props => [
        loginMsg,
        registerMsg,
        resendEmailMsg,
        resetMsg,
        requestResetMsg,
        loginStatus,
        registerStatus,
        resendEmailStatus,
        requestResetStatus,
        resetStatus,
        isLoginLoading,
        isRegisterLoading,
        isResendEmailLoading,
        isRequestResetLoading,
        isResetLoading,
      ];

  @override
  bool? get stringify => true;
}
