import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/domain_social/entities/post/post.dart';

class SocialState extends Equatable {
  final List<Post>? justForYouPosts;
  final List<Post>? trendingPosts;
  final List<Post>? followingPosts;
  final Post? currentPost;
  final PlatformFile? createPostThumbnail;
  final PlatformFile? sourceData;
  final bool? isCreatingPost;
  const SocialState({
    this.justForYouPosts,
    this.trendingPosts,
    this.followingPosts,
    this.sourceData,
    this.currentPost,
    this.createPostThumbnail,
    this.isCreatingPost,
  });

  SocialState copyWith({
    List<Post>? justForYouPosts,
    List<Post>? trendingPosts,
    List<Post>? followingPosts,
    Post? currentPost,
    PlatformFile? createPostThumbnail,
    PlatformFile? sourceData,
    bool? isCreatingPost,
  }) =>
      SocialState(
        justForYouPosts: justForYouPosts ?? this.justForYouPosts,
        trendingPosts: trendingPosts ?? this.trendingPosts,
        followingPosts: followingPosts ?? this.followingPosts,
        currentPost: currentPost ?? this.currentPost,
        createPostThumbnail: createPostThumbnail ?? this.createPostThumbnail,
        sourceData: sourceData ?? this.sourceData,
        isCreatingPost: isCreatingPost ?? this.isCreatingPost,
      );

  @override
  List<Object?> get props => [
        justForYouPosts,
        trendingPosts,
        followingPosts,
        currentPost,
        createPostThumbnail,
        sourceData,
        isCreatingPost,
      ];
  @override
  bool? get stringify => true;
}
