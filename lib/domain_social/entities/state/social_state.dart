import 'package:equatable/equatable.dart';
import 'package:musix/domain_social/entities/post/post.dart';

class SocialState extends Equatable {
  final List<Post>? justForYouPosts;
  final List<Post>? trendingPosts;
  final List<Post>? followingPosts;
  final Post? currentPost;
  const SocialState({
    this.justForYouPosts,
    this.trendingPosts,
    this.followingPosts,
    this.currentPost,
  });

  SocialState copyWith({
    List<Post>? justForYouPosts,
    List<Post>? trendingPosts,
    List<Post>? followingPosts,
    Post? currentPost,
  }) =>
      SocialState(
        justForYouPosts: justForYouPosts ?? this.justForYouPosts,
        trendingPosts: trendingPosts ?? this.trendingPosts,
        followingPosts: followingPosts ?? this.followingPosts,
        currentPost: currentPost ?? this.currentPost,
      );

  @override
  List<Object?> get props => [
        justForYouPosts,
        trendingPosts,
        followingPosts,
        currentPost,
      ];
  @override
  bool? get stringify => true;
}
