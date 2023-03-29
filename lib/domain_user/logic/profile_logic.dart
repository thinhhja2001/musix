import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/utils/utils.dart';

import '../entities/entities.dart';
import '../repo/profile_repo.dart';
import '../utils/convert_model_entity.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileState initialState,
    required this.profileRepo,
  }) : super(initialState) {
    on<GetProfileEvent>(_getProfile);
    on<UploadProfileEvent>(_uploadProfile);
    on<UploadAvatarProfileEvent>(_uploadAvatar);
    on<ChangePasswordProfileEvent>(_changePassword);
    on<FollowUserProfileEvent>(_followUser);
  }

  final ProfileRepo profileRepo;
  late String id;
  late String token;

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
            ProfileKey.global.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      id = event.userId;
      token = event.token;
      var userModel = await profileRepo.getProfile(token, id);

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.global.name,
        ], status: [
          Status.success,
        ]),
        user: convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.global.name,
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
          ProfileKey.global.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _getProfile error $e"), StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileKey.global.name,
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
            ProfileKey.uploadProfile.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.uploadProfile(
        token: token,
        id: id,
        phoneNumber: event.phoneNumber,
        fullName: event.fullName,
        birthday: event.birthday,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.uploadProfile.name,
        ], status: [
          Status.success,
        ]),
        user: convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.uploadProfile.name,
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
          ProfileKey.uploadProfile.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _uploadProfile error $e"), StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileKey.uploadAvatar.name,
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
            ProfileKey.uploadAvatar.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            ProfileKey.uploadAvatar.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.uploadAvatar(
        token: token,
        id: id,
        avatar: event.avatar,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.uploadAvatar.name,
        ], status: [
          Status.success,
        ]),
        user: convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.uploadAvatar.name,
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
          ProfileKey.uploadAvatar.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _uploadAvatar error $e"), StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileKey.uploadAvatar.name,
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
            ProfileKey.changePassword.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.changePassword(
        token: token,
        id: id,
        password: event.oldPassword,
        newPassword: event.newPassword,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.changePassword.name,
        ], status: [
          Status.success,
        ]),
        user: convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.changePassword.name,
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
          ProfileKey.changePassword.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(Exception("ProfileBloc _changePassword error $e"),
          StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileKey.changePassword.name,
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
            ProfileKey.followUser.name,
          ], status: [
            Status.loading,
          ]),
        ),
      );
      var userModel = await profileRepo.followUser(
        token: token,
        id: id,
        followId: event.followUserId,
      );

      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.followUser.name,
        ], status: [
          Status.success,
        ]),
        user: convertUserModelToUser(userModel.user!),
      ));
    } on ResponseException catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          ProfileKey.followUser.name,
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
          ProfileKey.followUser.name,
        ], status: [
          Status.error,
        ]),
      ));

      addError(
          Exception("ProfileBloc _followUser error $e"), StackTrace.current);
    }

    emit(state.copyWith(
      status: updateMapStatus(source: state.status, keys: [
        ProfileKey.followUser.name,
      ], status: [
        Status.idle,
      ]),
    ));
  }
}
