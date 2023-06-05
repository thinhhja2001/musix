import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:musix/domain_user/entities/entities.dart';
import '../post/post.dart';

class SocialState extends Equatable {
  final List<Post>? justForYouPosts;
  final List<Post>? trendingPosts;
  final List<Post>? followingPosts;
  final Post? currentPost;
  final File? createPostThumbnail;
  final File? sourceData;
  final bool? isCreatingPost;
  final int? createPostStatus;
  final bool? isModifyingPost;
  final int? modifyingPostStatus;
  final int? deletePostStatus;
  final List<Post>? userPosts;

  const SocialState({
    this.justForYouPosts,
    this.trendingPosts,
    this.followingPosts,
    this.sourceData,
    this.currentPost,
    this.createPostThumbnail,
    this.isCreatingPost,
    this.createPostStatus,
    this.isModifyingPost,
    this.modifyingPostStatus,
    this.deletePostStatus,
    this.userPosts,
  });

  SocialState copyWith({
    List<Post>? Function()? justForYouPosts,
    List<Post>? Function()? trendingPosts,
    List<Post>? Function()? followingPosts,
    Post? currentPost,
    File? Function()? createPostThumbnail,
    File? Function()? sourceData,
    bool? isCreatingPost,
    int? Function()? createPostStatus,
    bool? isModifyingPost,
    int? Function()? modifyingPostStatus,
    int? Function()? deletePostStatus,
    List<Post>? Function()? userPosts,
  }) =>
      SocialState(
        justForYouPosts:
            justForYouPosts != null ? justForYouPosts() : this.justForYouPosts,
        trendingPosts:
            trendingPosts != null ? trendingPosts() : this.trendingPosts,
        followingPosts:
            followingPosts != null ? followingPosts() : this.followingPosts,
        currentPost: currentPost ?? this.currentPost,
        createPostThumbnail: createPostThumbnail != null
            ? createPostThumbnail()
            : this.createPostThumbnail,
        sourceData: sourceData != null ? sourceData() : this.sourceData,
        isCreatingPost: isCreatingPost ?? this.isCreatingPost,
        createPostStatus: createPostStatus != null
            ? createPostStatus()
            : this.createPostStatus,
        isModifyingPost: isModifyingPost ?? this.isModifyingPost,
        modifyingPostStatus: modifyingPostStatus != null
            ? modifyingPostStatus()
            : this.modifyingPostStatus,
        deletePostStatus: deletePostStatus != null
            ? deletePostStatus()
            : this.deletePostStatus,
        userPosts: userPosts != null ? userPosts() : this.userPosts,
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
        createPostStatus,
        isModifyingPost,
        modifyingPostStatus,
        deletePostStatus,
        userPosts,
      ];
  @override
  bool? get stringify => false;
}
