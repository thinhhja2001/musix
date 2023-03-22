import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_auth/repo/auth_repo.dart';

import '../entities/event/auth_event.dart';
import '../entities/state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthState initialState,
    required this.authRepo,
  }) : super(initialState) {
    on<AuthLoginEvent>(_handleLoginEvent);
    on<AuthRegisterEvent>(_handleRegisterEvent);
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

    emit(
      state.copyWith(
          registerMsg: response.msg, registerStatus: response.status),
    );
  }
}
