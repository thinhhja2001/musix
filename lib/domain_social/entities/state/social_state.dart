import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
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
  });

  SocialState copyWith({
    List<Post>? justForYouPosts,
    List<Post>? trendingPosts,
    List<Post>? followingPosts,
    Post? currentPost,
    File? Function()? createPostThumbnail,
    File? Function()? sourceData,
    bool? isCreatingPost,
    int? Function()? createPostStatus,
    bool? isModifyingPost,
    int? Function()? modifyingPostStatus,
    int? Function()? deletePostStatus,
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
            : this.createPostStatus,
        isModifyingPost: isModifyingPost ?? this.isModifyingPost,
        modifyingPostStatus: modifyingPostStatus != null
            ? modifyingPostStatus()
            : this.modifyingPostStatus,
        deletePostStatus: deletePostStatus != null
            ? deletePostStatus()
            : this.deletePostStatus,
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
      ];
  @override
  bool? get stringify => false;
}
