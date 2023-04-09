import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/domain_social/entities/post/post.dart';

class SocialState extends Equatable {
  final List<Post>? justForYouPosts;
  final List<Post>? trendingPosts;
  final List<Post>? followingPosts;
  final Post? currentPost;
  final List<int>? createPostThumbnail;
  const SocialState({
    this.justForYouPosts,
    this.trendingPosts,
    this.followingPosts,
    this.currentPost,
    this.createPostThumbnail,
  });

  SocialState copyWith({
    List<Post>? justForYouPosts,
    List<Post>? trendingPosts,
    List<Post>? followingPosts,
    Post? currentPost,
    List<int>? createPostThumbnail,
  }) =>
      SocialState(
        justForYouPosts: justForYouPosts ?? this.justForYouPosts,
        trendingPosts: trendingPosts ?? this.trendingPosts,
        followingPosts: followingPosts ?? this.followingPosts,
        currentPost: currentPost ?? this.currentPost,
        createPostThumbnail: createPostThumbnail ?? this.createPostThumbnail,
      );

  @override
  List<Object?> get props => [
        justForYouPosts,
        trendingPosts,
        followingPosts,
        currentPost,
        createPostThumbnail,
      ];
  @override
  bool? get stringify => true;
}
