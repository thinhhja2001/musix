import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/entities/comment/comment.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/domain_social/entities/utils/social_mapper.dart';
import 'package:musix/domain_social/models/comment/comment_model.dart';
import 'package:musix/domain_social/models/post/post_model.dart';

// const testToken =
//     "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VydGVzdDIiLCJpYXQiOjE2Nzk3MzQ4NzQsImV4cCI6MTY4MjMyNjg3NH0.wlz5GF1g4NhUYiWcvDhv5BDovsJgpNCpozu6jNRA2LA";

class SocialBloc extends Bloc<SocialEvent, SocialState> {
  SocialBloc({
    required SocialState initialState,
    required this.authBloc,
    required this.commentRepo,
    required this.postRepo,
  }) : super(initialState) {
    authBloc.stream.listen((authState) {
      if (authState.username != null && authState.jwtToken != null) {
        testToken = authState.jwtToken!;
        socialMapper = SocialMapper(testToken);
      }
    });
    on<SocialGetListPostJustForYouEvent>(_handleGetListPostJustForYouEvent);
    on<SocialGetListPostTrendingEvent>(_handleGetListPostTrendingEvent);
    on<SocialGetListPostFollowingEvent>(_handleGetListPostFollowingEvent);
    on<SocialGetCommentsByPostIdEvent>(_handleGetCommentsByPostId);
    on<SocialGetPostEvent>(_handleGetPostEvent);
  }
  final CommentRepo commentRepo;
  final AuthBloc authBloc;
  final PostRepo postRepo;
  late final String testToken;
  late final SocialMapper socialMapper;
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
    print('getting list just 4 u');
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
    emit(state.copyWith(followingPosts: posts));
  }
}
