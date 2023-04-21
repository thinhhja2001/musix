import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_auth/logic/auth_bloc.dart';
import '../../utils/utils.dart';
import '../entities/entities.dart';
import '../repo/profile_repo.dart';
import '../utils/convert_model_entity.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileState initialState,
    required this.authBloc,
    required this.profileRepo,
  }) : super(initialState) {
    authBloc.stream.listen((authState) {
      debugPrint('AuthBloc Print: $authState');
      if (authState.userId != null &&
          authState.jwtToken != null &&
          authState.jwtToken != "") {
        token = authState.jwtToken!;
      }
    });
    on<GetProfileEvent>(_getProfile);
    on<UploadProfileEvent>(_uploadProfile);
    on<UploadAvatarProfileEvent>(_uploadAvatar);
    on<ChangePasswordProfileEvent>(_changePassword);
    on<FollowUserProfileEvent>(_followUser);
    on<ProfileResetEvent>(_profileResetEvent);
  }
  final AuthBloc authBloc;
  final ProfileRepo profileRepo;
  String token = "";

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> _getProfile(
      GetProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileStatusKey.global.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.getProfile(token);

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.global.name,
        ], status: [
          Status.success,
        ]),
        user: () => convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.global.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("ProfileBloc _getProfile error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.global.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _getProfile error $e"), StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileStatusKey.global.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _uploadProfile(
      UploadProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileStatusKey.uploadProfile.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.uploadProfile(
        token: token,
        phoneNumber: event.phoneNumber,
        fullName: event.fullName,
        birthday: event.birthday,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.uploadProfile.name,
        ], status: [
          Status.success,
        ]),
        user: () => convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.uploadProfile.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("ProfileBloc _uploadProfile error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.uploadProfile.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _uploadProfile error $e"), StackTrace.current);
    }
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileStatusKey.uploadProfile.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _uploadAvatar(
      UploadAvatarProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileStatusKey.uploadAvatar.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileStatusKey.uploadAvatar.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.uploadAvatar(
        token: token,
        avatar: event.avatar,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.uploadAvatar.name,
        ], status: [
          Status.success,
        ]),
        user: () => convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.uploadAvatar.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("ProfileBloc _uploadAvatar error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.uploadAvatar.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _uploadAvatar error $e"), StackTrace.current);
    }
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileStatusKey.uploadAvatar.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _changePassword(
      ChangePasswordProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileStatusKey.changePassword.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var result = await profileRepo.changePassword(
        token: token,
        password: event.oldPassword,
        newPassword: event.newPassword,
      );
      if (result) {
        emit(state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileStatusKey.changePassword.name,
          ], status: [
            Status.success,
          ]),
        ));
      } else {
        throw Exception("Process Failed");
      }
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.changePassword.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("ProfileBloc _changePassword error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.changePassword.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("ProfileBloc _changePassword error $e"),
          StackTrace.current);
    }
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileStatusKey.changePassword.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _followUser(
      FollowUserProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileStatusKey.followUser.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.followUser(
        token: token,
        followId: event.followUserId,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.followUser.name,
        ], status: [
          Status.success,
        ]),
        user: () => convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.followUser.name,
        ], status: [
          Status.error,
        ]),
        error: e,
      ));

      addError(Exception("ProfileBloc _followUser error ${e.toString()}"),
          StackTrace.current);
    } on Exception catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileStatusKey.followUser.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _followUser error $e"), StackTrace.current);
    }
    await Future.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileStatusKey.followUser.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }

  FutureOr<void> _profileResetEvent(
      ProfileResetEvent event, Emitter<ProfileState> emit) {
    emit(
      state.copyWith(
        status: {
          ProfileStatusKey.global.name: Status.idle,
        },
        user: () => null,
      ),
    );
  }
}
