import 'package:musix/domain_user/models/profile.dart';

import 'user_role.dart';

class User {
  String id;
  String username;
  String email;
  Profile profile;
  UserRole role;
  bool enabled;
  List followings;
  List followers;
  User({
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

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      enabled: data['enabled'] as bool,
      profile: Profile.fromJson(data['profile'] as Map<String, dynamic>),
      followings: List<User>.from(
        (data['followings'] as List).map(
          (x) => x,
        ),
      ),
      role: data["role"] == "USER" ? UserRole.user : UserRole.admin,
      followers: List<User>.from(
        (data['followers'] as List).map<User>(
          (x) => x,
        ),
      ),
    );
  }
}
