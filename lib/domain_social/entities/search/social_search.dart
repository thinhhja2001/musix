import 'package:equatable/equatable.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/domain_user/entities/entities.dart';

class SocialSearchValue extends Equatable {
  final List<Post>? posts;
  final List<User>? users;

  const SocialSearchValue({
    this.posts,
    this.users,
  });

  SocialSearchValue copyWith({
    List<Post>? posts,
    List<User>? users,
  }) {
    return SocialSearchValue(
      posts: posts ?? this.posts,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [
        posts,
        users,
      ];

  @override
  String toString() {
    return "SocialSearch(${posts?.length}, ${users?.length})";
  }
}
