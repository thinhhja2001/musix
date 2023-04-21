import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/entities/comment/comment.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/domain_social/entities/utils/social_mapper.dart';
import 'package:musix/domain_social/models/comment/comment_model.dart';
import 'package:musix/domain_social/models/post/post_model.dart';

const testTokenConst =
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VydGVzdDIiLCJpYXQiOjE2Nzk3MzQ4NzQsImV4cCI6MTY4MjMyNjg3NH0.wlz5GF1g4NhUYiWcvDhv5BDovsJgpNCpozu6jNRA2LA";

class SocialBloc extends Bloc<SocialEvent, SocialState> {
  SocialBloc({
    required SocialState initialState,
    required this.authBloc,
    required this.commentRepo,
    required this.postRepo,
  }) : super(initialState) {
    authBloc.stream.listen((authState) {
      if (authState.username != null &&
          authState.jwtToken != null &&
          authState.jwtToken != "") {
        testToken = authState.jwtToken!;
        socialMapper = SocialMapper(testToken);
      }
    });
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
    on<SocialLikeOrDislikePostEvent>(_handleLikeOrDislikePostEvent);
    on<SocialDeletePostEvent>(_handleDeletePostEvent);
    on<SocialLoadUserPostEvent>(_handleLoadUserPostEvent);
    on<SocialProfileBackEvent>(_handleSocialProfileBackEvent);
  }
  final CommentRepo commentRepo;
  final AuthBloc authBloc;
  final PostRepo postRepo;
  final int _countPerPage = 2;
  int _userPostCurrentPage = 0;
  int _followingPostCurrentPage = 0;
  int _just4YouPostCurrentPage = 0;
  int _trendingPostCurrentPage = 0;
  String testToken = "";
  late SocialMapper socialMapper;
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
    //TODO Implemnent get list post of type just for you
    List<PostModel> postsModel = await postRepo.getPosts(
      page: _just4YouPostCurrentPage++,
      size: _countPerPage,
      token: testToken,
    );
    List<Post> posts =
        await socialMapper.listPostsFromListPostsModel(postsModel);
    if (posts.isNotEmpty) {
      emit(state
          .copyWith(justForYouPosts: [...?state.justForYouPosts, ...posts]));
    }
    debugPrint("$posts");
  }

  FutureOr<void> _handleGetListPostTrendingEvent(
      SocialGetListPostTrendingEvent event, Emitter<SocialState> emit) async {
    //TODO Implemnent get list post of type trending
    List<PostModel> postsModel = await postRepo.getPosts(
      page: _trendingPostCurrentPage++,
      size: _countPerPage,
      token: testToken,
    );

    List<Post> posts =
        await socialMapper.listPostsFromListPostsModel(postsModel);
    if (posts.isNotEmpty) {
      emit(state.copyWith(trendingPosts: [...?state.trendingPosts, ...posts]));
    }
  }

  FutureOr<void> _handleGetListPostFollowingEvent(
      SocialGetListPostFollowingEvent event, Emitter<SocialState> emit) async {
    //TODO Implemnent get list post of type following
    List<PostModel> postsModel = await postRepo.getPosts(
      page: _followingPostCurrentPage++,
      size: _countPerPage,
      token: testToken,
    );
    List<Post> posts =
        await socialMapper.listPostsFromListPostsModel(postsModel);
    debugPrint("$posts");
    if (posts.isNotEmpty) {
      emit(
          state.copyWith(followingPosts: [...?state.followingPosts, ...posts]));
    }
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

  FutureOr<void> _handleLikeOrDislikePostEvent(
      SocialLikeOrDislikePostEvent event, Emitter<SocialState> emit) async {
    debugPrint("post id is ${event.postId}");
    final response = await postRepo.likeOrDislikePost(event.postId, testToken);
    debugPrint("response is ${response.status}");
  }

  FutureOr<void> _handleDeletePostEvent(
      SocialDeletePostEvent event, Emitter<SocialState> emit) async {
    final response = await postRepo.deletePost(event.post.id!, testToken);
    emit(state.copyWith(deletePostStatus: () => response.status));
    if (response.status == 200) {
      List<Post> followingPosts = List.empty(growable: true);
      List<Post> justForYouPosts = List.empty(growable: true);
      List<Post> trendingPosts = List.empty(growable: true);
      List<Post> userPosts = List.empty(growable: true);
      for (var post in state.followingPosts!) {
        followingPosts.add(post);
      }
      for (var post in state.justForYouPosts!) {
        justForYouPosts.add(post);
      }
      for (var post in state.trendingPosts!) {
        trendingPosts.add(post);
      }

      followingPosts.remove(event.post);
      justForYouPosts.remove(event.post);
      trendingPosts.remove(event.post);
      userPosts.remove(event.post);
      emit(state.copyWith(
        followingPosts: followingPosts,
        trendingPosts: trendingPosts,
        justForYouPosts: justForYouPosts,
        userPosts: () => userPosts,
      ));
    }
    emit(state.copyWith(deletePostStatus: () => null));
  }

  FutureOr<void> _handleLoadUserPostEvent(
      SocialLoadUserPostEvent event, Emitter<SocialState> emit) async {
    final postsModel = await postRepo.getPostsByUsername(
        username: event.username,
        page: _userPostCurrentPage++,
        size: _countPerPage,
        token: testToken);
    if (postsModel.isNotEmpty) {
      final posts = await socialMapper.listPostsFromListPostsModel(postsModel);
      emit(state.copyWith(userPosts: () => [...?state.userPosts, ...posts]));
    }
  }

  FutureOr<void> _handleSocialProfileBackEvent(
      SocialProfileBackEvent event, Emitter<SocialState> emit) {
    _userPostCurrentPage = 0;
    emit(state.copyWith(userPosts: () => null));
  }
}
