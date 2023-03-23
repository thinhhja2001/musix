import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_auth/repo/auth_repo.dart';
import 'package:musix/domain_user/models/user.dart';

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
  }
  final AuthRepo authRepo;
  FutureOr<void> _handleLoginEvent(AuthLoginEvent event, Emitter emit) async {
    emit(state.copyWith(isLoginLoading: true));
    final response = await authRepo.login(event.request);
    emit(state.copyWith(isLoginLoading: false));

    emit(
      state.copyWith(loginMsg: response.msg, loginStatus: response.status),
    );
  }

  FutureOr<void> _handleRegisterEvent(
      AuthRegisterEvent event, Emitter emit) async {
    emit(state.copyWith(isRegisterLoading: true));
    final response = await authRepo.register(event.request);

    emit(state.copyWith(isRegisterLoading: false));
    if (response.status == 200) {
      print(response.data?['user']['enabled']);
      final user = User.fromJson(response.data?['user']);
      GetIt.I.registerSingleton<User>(user);
    }
    emit(
      state.copyWith(
          registerMsg: response.msg, registerStatus: response.status),
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
}
