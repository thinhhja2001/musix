import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_auth/repo/auth_repo.dart';
import 'package:musix/domain_user/entities/entities.dart';
import 'package:musix/domain_user/models/user_info/user_model.dart';

import '../../domain_user/utils/convert_model_entity.dart';
import '../entities/event/auth_event.dart';
import '../entities/state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthState initialState,
    required this.authRepo,
  }) : super(initialState) {
    on<AuthLoginEvent>(_handleLoginEvent);
    on<AuthRegisterEvent>(_handleRegisterEvent);
    on<AuthResendVerificationEmailEvent>(_handleResendVerificationEmailEvent);
    on<AuthRequestResetPasswordEvent>(_handleRequestResetPasswordEvent);
    on<AuthResetPasswordEvent>(_handleResetPasswordEvent);
    on<AuthResetPasswordScreenBackEvent>(_handleResetPasswordBackEvent);
    on<AuthResetCurrentRequestPasswordStateEvent>(
        _handleResetCurrentRequestPasswordStateEvent);
  }
  final AuthRepo authRepo;
  FutureOr<void> _handleLoginEvent(AuthLoginEvent event, Emitter emit) async {
    emit(state.copyWith(isLoginLoading: true));
    final response = await authRepo.login(event.request);
    emit(state.copyWith(isLoginLoading: false));

    emit(
      state.copyWith(
        loginMsg: response.msg,
        loginStatus: response.status,
        jwtToken: response.data?["token"]["token"],
        userId: response.data?["user"]["id"],
        username: response.data?["user"]["username"],
      ),
    );
  }

  FutureOr<void> _handleRegisterEvent(
      AuthRegisterEvent event, Emitter emit) async {
    emit(state.copyWith(isRegisterLoading: true));
    final response = await authRepo.register(event.request);

    emit(state.copyWith(isRegisterLoading: false));
    if (response.status == 200) {
      final user = UserModel.fromJson(response.data?['user']);
      GetIt.I.registerSingleton<User>(convertUserModelToUser(user));
    }
    emit(
      state.copyWith(
        registerMsg: response.msg,
        registerStatus: response.status,
        jwtToken: response.data?["token"]["token"],
        userId: response.data?["user"]["id"],
        username: response.data?["user"]["username"],
      ),
    );
  }

  FutureOr<void> _handleResendVerificationEmailEvent(
      AuthResendVerificationEmailEvent event, Emitter emit) async {
    emit(state.copyWith(isResendEmailLoading: true));
    final response = await authRepo.resendVerificationEmail(event.username);
    emit(state.copyWith(isResendEmailLoading: false));

    emit(state.copyWith(
        resendEmailMsg: response.msg, resendEmailStatus: response.status));
  }

  FutureOr<void> _handleRequestResetPasswordEvent(
      AuthRequestResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isRequestResetLoading: true));
    final response = await authRepo.requestResetOtp(event.email);
    emit(state.copyWith(isRequestResetLoading: false));
    if (response.status == 200) {
      GetIt.I
          .registerSingleton<String>(event.email, instanceName: "currentEmail");
    }
    emit(state.copyWith(
        requestResetStatus: response.status, requestResetMsg: response.msg));
  }

  FutureOr<void> _handleResetPasswordEvent(
      AuthResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isResetLoading: true));

    final response = await authRepo.resetPassword(event.request);

    emit(state.copyWith(isResetLoading: false));
    emit(state.copyWith(resetStatus: response.status, resetMsg: response.msg));
  }

  FutureOr<void> _handleResetPasswordBackEvent(
      AuthResetPasswordScreenBackEvent event, Emitter<AuthState> emit) async {
    GetIt.I.unregister<String>(instanceName: "currentEmail");
    add(AuthResetCurrentRequestPasswordStateEvent());
  }

  FutureOr<void> _handleResetCurrentRequestPasswordStateEvent(
      AuthResetCurrentRequestPasswordStateEvent event,
      Emitter<AuthState> emit) {
    emit(state.copyWith(
        requestResetMsg: null,
        requestResetStatus: null,
        isRequestResetLoading: false));
  }
}
