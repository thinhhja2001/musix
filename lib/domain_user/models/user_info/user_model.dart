import 'package:musix/domain_user/models/user_info/profile_model.dart';

import '../../utils/user_role.dart';

class UserModel {
  String id;
  String username;
  String email;
  ProfileModel profile;
  UserRole role;
  bool enabled;
  List followings;
  List followers;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
    required this.enabled,
    required this.followings,
    required this.followers,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'enabled': enabled,
      'profile': profile.toJson(),
      'followings': followings.map((x) => x.toJson()).toList(),
      'followers': followers.map((x) => x.toJson()).toList(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      enabled: data['enabled'] as bool,
      profile: ProfileModel.fromJson(data['profile'] as Map<String, dynamic>),
      followings: data['followings'] != null
          ? List<UserModel>.from(
              (data['followings'] as List).map(
                (x) => x,
              ),
            )
          : [],
      role: data["role"] == "USER" ? UserRole.user : UserRole.admin,
      followers: data['followers'] != null
          ? List<UserModel>.from(
              (data['followers'] as List).map<UserModel>(
                (x) => x,
              ),
            )
          : [],
    );
  }
}
