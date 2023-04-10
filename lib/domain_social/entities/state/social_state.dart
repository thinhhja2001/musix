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
  final XFile? createPostThumbnail;
  final PlatformFile? sourceData;
  final bool? isCreatingPost;
  final int? createPostStatus;
  const SocialState({
    this.justForYouPosts,
    this.trendingPosts,
    this.followingPosts,
    this.sourceData,
    this.currentPost,
    this.createPostThumbnail,
    this.isCreatingPost,
    this.createPostStatus,
  });

  SocialState copyWith({
    List<Post>? justForYouPosts,
    List<Post>? trendingPosts,
    List<Post>? followingPosts,
    Post? currentPost,
    XFile? Function()? createPostThumbnail,
    PlatformFile? Function()? sourceData,
    bool? isCreatingPost,
    int? Function()? createPostStatus,
  }) =>
      SocialState(
          justForYouPosts: justForYouPosts ?? this.justForYouPosts,
          trendingPosts: trendingPosts ?? this.trendingPosts,
          followingPosts: followingPosts ?? this.followingPosts,
          currentPost: currentPost ?? this.currentPost,
          createPostThumbnail: createPostThumbnail != null
              ? createPostThumbnail()
              : this.createPostThumbnail,
          sourceData: sourceData != null ? sourceData() : this.sourceData,
          isCreatingPost: isCreatingPost ?? this.isCreatingPost,
          createPostStatus: createPostStatus != null
              ? createPostStatus()
              : this.createPostStatus);

  @override
  List<Object?> get props => [
        justForYouPosts,
        trendingPosts,
        followingPosts,
        currentPost,
        createPostThumbnail,
        sourceData,
        isCreatingPost,
        createPostStatus,
      ];
  @override
  bool? get stringify => true;
}
