import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musix/domain_social/entities/comment/comment.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/domain_social/entities/utils/social_mapper.dart';
import 'package:musix/domain_social/models/comment/comment_model.dart';
import 'package:musix/domain_social/models/post/post_model.dart';
import 'package:musix/domain_social/repository/comment/comment_repo.dart';

import '../entities/event/social_event.dart';
import '../entities/state/social_state.dart';
import '../repository/post/post_repo.dart';

const testToken =
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VydGVzdDIiLCJpYXQiOjE2Nzk3MzQ4NzQsImV4cCI6MTY4MjMyNjg3NH0.wlz5GF1g4NhUYiWcvDhv5BDovsJgpNCpozu6jNRA2LA";

class SocialBloc extends Bloc<SocialEvent, SocialState> {
  SocialBloc({
    required SocialState initialState,
    required this.commentRepo,
    required this.postRepo,
  }) : super(initialState) {
    on<SocialGetListPostJustForYouEvent>(_handleGetListPostJustForYouEvent);
    on<SocialGetListPostTrendingEvent>(_handleGetListPostTrendingEvent);
    on<SocialGetListPostFollowingEvent>(_handleGetListPostFollowingEvent);
    on<SocialGetCommentsByPostIdEvent>(_handleGetCommentsByPostId);
    on<SocialGetPostEvent>(_handleGetPostEvent);
    on<SocialAddPostThumbnailEvent>(_handleAddPostThumbnailEvent);
    on<SocialAddPostDataSourceEvent>(_handleAddPostDataSourceEvent);
    on<SocialCreatePostEvent>(_handleCreatePostEvent);
    on<SocialRemovePostThumbnailEvent>(_handleRemovePostThumbnailEvent);
    on<SocialRemovePostDataSourceEvent>(_handleRemovePostDataSourceEvent);
    on<SocialCreatePostBackEvent>(_handleSocialCreatePostBackEvent);
    on<SocialUpdateCreatePostStatus>(_handleSocialUpdateCreatePostStatus);
    on<SocialModifyPostEvent>(_handleModifyPostEvent);
    on<SocialUpdateModifyPostStatus>(_handleModifyPostStatus);
    on<SocialModifyPostBackEvent>(_handleModifyPostBackEvent);
  }
  final CommentRepo commentRepo;
  final PostRepo postRepo;
  final SocialMapper socialMapper = SocialMapper();
  FutureOr<void> _handleGetCommentsByPostId(
      SocialGetCommentsByPostIdEvent event, Emitter<SocialState> emit) async {
    List<CommentModel> commentModels =
        await commentRepo.getCommentsByPostId(event.postId, testToken);
    List<Comment> comments =
        await socialMapper.listCommentFromListCommentModel(commentModels);
    emit(
      state.copyWith(
        currentPost: state.currentPost?.copyWith(comments: comments),
      ),
    );
  }

  FutureOr<void> _handleGetPostEvent(
      SocialGetPostEvent event, Emitter<SocialState> emit) async {
    PostModel? postModel = await postRepo.getPostById(event.postId, testToken);
    Post post = await socialMapper.postFromPostModel(postModel!);
    emit(state.copyWith(currentPost: post));
  }

  FutureOr<void> _handleGetListPostJustForYouEvent(
      SocialGetListPostJustForYouEvent event, Emitter<SocialState> emit) async {
    List<PostModel> postsModel = await postRepo.getAllPosts(testToken);
    //TODO Implemnent get list post of type just for you
    List<Post> posts =
        await socialMapper.listPostsFromListPostsModel(postsModel);
    print('just 4 u posts');
    print(posts);
    emit(state.copyWith(justForYouPosts: posts));
  }

  FutureOr<void> _handleGetListPostTrendingEvent(
      SocialGetListPostTrendingEvent event, Emitter<SocialState> emit) async {
    List<PostModel> postsModel = await postRepo.getAllPosts(testToken);
    //TODO Implemnent get list post of type trending

    List<Post> posts =
        await socialMapper.listPostsFromListPostsModel(postsModel);
    emit(state.copyWith(trendingPosts: posts));
  }

  FutureOr<void> _handleGetListPostFollowingEvent(
      SocialGetListPostFollowingEvent event, Emitter<SocialState> emit) async {
    List<PostModel> postsModel = await postRepo.getAllPosts(testToken);
    //TODO Implemnent get list post of type following
    List<Post> posts =
        await socialMapper.listPostsFromListPostsModel(postsModel);
    print(posts);
    emit(state.copyWith(followingPosts: posts));
  }

  FutureOr<void> _handleAddPostThumbnailEvent(
      SocialAddPostThumbnailEvent event, Emitter<SocialState> emit) async {
    emit(state.copyWith(createPostThumbnail: () => event.thumbnail));
  }

  FutureOr<void> _handleAddPostDataSourceEvent(
      SocialAddPostDataSourceEvent event, Emitter<SocialState> emit) async {
    emit(state.copyWith(sourceData: () => event.dataSource));
  }

  FutureOr<void> _handleCreatePostEvent(
      SocialCreatePostEvent event, Emitter<SocialState> emit) async {
    emit(state.copyWith(isCreatingPost: true));
    final response =
        await postRepo.createNewPost(event.postRegistryModel, testToken);
    add(SocialUpdateCreatePostStatus(response.status));
    emit(state.copyWith(isCreatingPost: false));
  }

  FutureOr<void> _handleRemovePostThumbnailEvent(
      SocialRemovePostThumbnailEvent event, Emitter<SocialState> emit) {
    emit(state.copyWith(createPostThumbnail: () => null));
  }

  FutureOr<void> _handleRemovePostDataSourceEvent(
      SocialRemovePostDataSourceEvent event, Emitter<SocialState> emit) {
    emit(state.copyWith(
      sourceData: () => null,
    ));
  }

  FutureOr<void> _handleSocialCreatePostBackEvent(
      SocialCreatePostBackEvent event, Emitter<SocialState> emit) {
    add(SocialRemovePostThumbnailEvent());
    add(SocialRemovePostDataSourceEvent());
    add(SocialUpdateCreatePostStatus(null));
  }

  FutureOr<void> _handleSocialUpdateCreatePostStatus(
      SocialUpdateCreatePostStatus event, Emitter<SocialState> emit) {
    emit(state.copyWith(createPostStatus: () => event.status));
  }

  FutureOr<void> _handleModifyPostEvent(
      SocialModifyPostEvent event, Emitter<SocialState> emit) async {
    emit(state.copyWith(isModifyingPost: true));
    final response = await postRepo.modifyPost(
        postId: event.postId,
        postRegistryModel: event.postRegistryModel,
        token: testToken);
    add(SocialUpdateModifyPostStatus(response.status));
    emit(state.copyWith(isModifyingPost: false));
  }

  FutureOr<void> _handleModifyPostStatus(
      SocialUpdateModifyPostStatus event, Emitter<SocialState> emit) {
    emit(state.copyWith(modifyingPostStatus: () => event.status));
  }

  FutureOr<void> _handleModifyPostBackEvent(
      SocialModifyPostBackEvent event, Emitter<SocialState> emit) {
    add(SocialRemovePostThumbnailEvent());
    add(SocialRemovePostDataSourceEvent());
    add(SocialUpdateModifyPostStatus(null));
  }
}
