import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  String? loginMsg;
  String? registerMsg;
  int? loginStatus;
  int? registerStatus;
  bool? isLoginLoading;
  bool? isRegisterLoading;
  AuthState({
    this.loginMsg,
    this.registerMsg,
    this.loginStatus,
    this.registerStatus,
    this.isLoginLoading,
    this.isRegisterLoading,
  });
  AuthState copyWith({
    String? loginMsg,
    String? registerMsg,
    int? loginStatus,
    int? registerStatus,
    bool? isLoginLoading,
    bool? isRegisterLoading,
  }) =>
      AuthState(
        loginMsg: loginMsg ?? this.loginMsg,
        registerMsg: registerMsg ?? this.registerMsg,
        loginStatus: loginStatus ?? this.loginStatus,
        registerStatus: registerStatus ?? this.registerStatus,
        isLoginLoading: isLoginLoading ?? this.isLoginLoading,
        isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      );

  @override
  List<Object?> get props => [
        loginMsg,
        registerMsg,
        loginStatus,
        registerStatus,
        isLoginLoading,
        isRegisterLoading
      ];

  @override
  bool? get stringify => true;
}
