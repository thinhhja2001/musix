import 'profile_model.dart';

import '../../utils/user_role.dart';

class UserModel {
  String id;
  String username;
  String email;
  ProfileModel profile;
  UserRole role;
  bool enabled;
  List<MiniUserModel> followings;
  List<MiniUserModel> followers;
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
    var followings = <MiniUserModel>[];
    if (data['followings'] != null) {
      data['followings'].forEach((v) {
        followings.add(MiniUserModel.fromJson(v));
      });
    }

    var followers = <MiniUserModel>[];
    if (data['followers'] != null) {
      data['followers'].forEach((v) {
        followers.add(MiniUserModel.fromJson(v));
      });
    }
    return UserModel(
      id: data['id'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      enabled: data['enabled'] as bool,
      profile: ProfileModel.fromJson(data['profile'] as Map<String, dynamic>),
      followings: followings,
      role: data["role"] == "USER" ? UserRole.user : UserRole.admin,
      followers: followers,
    );
  }
}

class MiniUserModel {
  String id;
  ProfileModel profile;

  MiniUserModel({
    required this.id,
    required this.profile,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'profile': profile.toJson(),
    };
  }

  factory MiniUserModel.fromJson(Map<String, dynamic> data) {
    return MiniUserModel(
      id: data['id'] as String,
      profile: ProfileModel.fromJson(data['profile'] as Map<String, dynamic>),
    );
  }
}
