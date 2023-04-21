class ProfileEvent {
  const ProfileEvent();
}

class GetProfileEvent implements ProfileEvent {
  const GetProfileEvent();
}

class UploadProfileEvent implements ProfileEvent {
  final String? fullName;
  final String? birthday;
  final String? phoneNumber;

  const UploadProfileEvent({
    this.birthday,
    this.phoneNumber,
    this.fullName,
  });
}

class UploadAvatarProfileEvent implements ProfileEvent {
  final List<int> avatar;

  const UploadAvatarProfileEvent(this.avatar);
}

class ChangePasswordProfileEvent implements ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordProfileEvent(this.oldPassword, this.newPassword);
}

class FollowUserProfileEvent implements ProfileEvent {
  final String followUserId;

  const FollowUserProfileEvent(this.followUserId);
}

class ProfileResetEvent implements ProfileEvent {}
