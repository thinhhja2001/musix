import 'package:equatable/equatable.dart';

import '../utils/user_role.dart';
import 'profile.dart';

class User extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final Profile? profile;
  final UserRole? role;
  final bool? enable;
  final List<User>? followers;
  final List<User>? followings;

  const User({
    this.id,
    this.username,
    this.email,
    this.profile,
    this.role,
    this.enable,
    this.followers,
    this.followings,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    Profile? profile,
    UserRole? role,
    bool? enable,
    List<User>? followers,
    List<User>? followings,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profile: profile ?? this.profile,
      role: role ?? this.role,
      enable: enable ?? this.enable,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        profile,
        role,
        enable,
        followings,
        followers,
      ];

  @override
  bool? get stringify => true;
}
