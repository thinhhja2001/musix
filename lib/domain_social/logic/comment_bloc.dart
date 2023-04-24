import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/utils/utils.dart';

import '../../config/exporter.dart';
import '../entities/entities.dart';
import '../models/comment/request/create_comment_request.dart';
import '../models/comment/request/modify_comment_request.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc({
    required CommentState initialState,
    required this.authBloc,
    required this.commentRepo,
  }) : super(initialState) {
    authBloc.stream.listen((authState) {
      if (authState.username != null &&
          authState.jwtToken != null &&
          authState.jwtToken != "") {
        token = authState.jwtToken!;
        socialMapper = SocialMapper(token);
      }
    });
    on<GetCommentsEvent>(_getComments);
    on<FilterCommentEvent>(_filterComments);
    on<CreateCommentEvent>(_createComment);
    on<EditCommentEvent>(_editComment);
    on<LikeCommentEvent>(_likeComment);
    on<DeleteCommentEvent>(_deleteComment);
    on<RelyCommentEvent>(_relyComment);
    on<GetRelyCommentsEvent>(_getRelyComments);
    on<ResetCommentsEvent>(_resetCommentsEvent);
  }
  final AuthBloc authBloc;
  final CommentRepo commentRepo;
  String token = "";
  late SocialMapper socialMapper;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> _getComments(
      GetCommentsEvent event, Emitter<CommentState> emit) async {
    emit(state.copyWith(
      comments: event.comments,
      postId: event.postId,
    ));
  }

  FutureOr<void> _filterComments(
      FilterCommentEvent event, Emitter<CommentState> emit) async {
    var comments = state.comments;
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.global.name,
        ], status: [
          Status.loading,
        ]),
        isFilter: event.turnOnFilter,
      ),
    );
    if (event.turnOnFilter) {
      comments?.sort(
          (a, b) => (a.lastModified ?? 0).compareTo(b.lastModified ?? 0));

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.global.name,
          ], status: [
            Status.success,
          ]),
          comments: comments,
        ),
      );
    } else {
      comments
          ?.sort((a, b) => (a.dateCreated ?? 0).compareTo(b.dateCreated ?? 0));
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.global.name,
          ], status: [
            Status.success,
          ]),
          comments: comments,
        ),
      );
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.global.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _createComment(
      CreateCommentEvent event, Emitter<CommentState> emit) async {
    var comments = state.comments ?? [];
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.loading,
        ]),
      ),
    );
    try {
      var commentModel = await commentRepo.createComment(
          CreateCommentModel(
            content: event.content,
            postId: state.postId,
          ),
          token);
      var comment = await socialMapper.commentFromCommentModel(commentModel);
      comments.add(comment);
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.single.name,
          ], status: [
            Status.success,
          ]),
          comments: comments,
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.single.name,
          ], status: [
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(Exception("CommentBloc _createComment error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _likeComment(
      LikeCommentEvent event, Emitter<CommentState> emit) async {
    var comments =
        event.isRely ? state.relyComments ?? [] : state.comments ?? [];
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.loading,
        ]),
      ),
    );
    try {
      var commentModel =
          await commentRepo.likeOrDislikeComment(event.commentId, token);
      var comment = await socialMapper.commentFromCommentModel(commentModel);
      comments[comments.indexWhere((element) => element.id == comment.id)] =
          comment;
      if (event.isRely) {
        emit(
          state.copyWith(
            status: updateMapStatus(source: state.status, keys: [
              CommentStatusKey.single.name,
            ], status: [
              Status.success,
            ]),
            relyComments: comments,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: updateMapStatus(source: state.status, keys: [
              CommentStatusKey.single.name,
            ], status: [
              Status.success,
            ]),
            comments: comments,
          ),
        );
      }
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.single.name,
          ], status: [
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(Exception("CommentBloc _likeComment error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _relyComment(
      RelyCommentEvent event, Emitter<CommentState> emit) async {
    var replyComments = state.relyComments ?? [];
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
          CommentStatusKey.rely.name,
        ], status: [
          Status.loading,
          Status.loading,
        ]),
      ),
    );
    try {
      var replyCommentModel = await commentRepo.replyComment(
          event.commentId,
          CreateCommentModel(
            content: event.content,
            postId: state.postId,
          ),
          token);
      var replyComment =
          await socialMapper.commentFromCommentModel(replyCommentModel);
      replyComments.add(replyComment);

      var commentsParent = state.comments ?? [];
      var commentModel =
          await commentRepo.getComment(state.selectedCommentId!, token);
      var comment = await socialMapper.commentFromCommentModel(commentModel);
      commentsParent[commentsParent
          .indexWhere((element) => element.id == comment.id)] = comment;

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.single.name,
            CommentStatusKey.rely.name,
          ], status: [
            Status.success,
            Status.success,
          ]),
          relyComments: replyComments,
          comments: commentsParent,
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.single.name,
            CommentStatusKey.rely.name,
          ], status: [
            Status.error,
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(Exception("CommentBloc _relyComment error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
          CommentStatusKey.rely.name,
        ], status: [
          Status.idle,
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _editComment(
      EditCommentEvent event, Emitter<CommentState> emit) async {
    var comments =
        event.isRely ? state.relyComments ?? [] : state.comments ?? [];
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.loading,
        ]),
      ),
    );
    try {
      var commentModel = await commentRepo.modifyComment(
          ModifyCommentModel(
            commentId: event.commentId,
            newContent: event.content,
          ),
          token);
      var comment = await socialMapper.commentFromCommentModel(commentModel);
      comments[comments.indexWhere((element) => element.id == comment.id)] =
          comment;
      if (event.isRely) {
        emit(
          state.copyWith(
            status: updateMapStatus(source: state.status, keys: [
              CommentStatusKey.single.name,
            ], status: [
              Status.success,
            ]),
            relyComments: comments,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: updateMapStatus(source: state.status, keys: [
              CommentStatusKey.single.name,
            ], status: [
              Status.success,
            ]),
            comments: comments,
          ),
        );
      }
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.single.name,
          ], status: [
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(Exception("CommentBloc _editComment error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _deleteComment(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    var comments =
        event.isRely ? state.relyComments ?? [] : state.comments ?? [];
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.loading,
        ]),
      ),
    );
    try {
      if (event.isRely) {
        var responseRely = await commentRepo.deleteReplyComment(
            state.selectedCommentId!, event.commentId, token);
        if (responseRely) {
          comments.removeWhere((e) => e.id == event.commentId);
        }
        var commentsParent = state.comments ?? [];
        var commentModel =
            await commentRepo.getComment(state.selectedCommentId!, token);
        var comment = await socialMapper.commentFromCommentModel(commentModel);
        commentsParent[commentsParent
            .indexWhere((element) => element.id == comment.id)] = comment;
        emit(
          state.copyWith(
            status: updateMapStatus(source: state.status, keys: [
              CommentStatusKey.single.name,
            ], status: [
              Status.success,
            ]),
            comments: commentsParent,
            relyComments: comments,
          ),
        );
      } else {
        var responseRely = await commentRepo.deleteComment(
            event.commentId, state.postId!, token);
        if (responseRely) {
          comments.removeWhere((e) => e.id == event.commentId);
        }
        emit(
          state.copyWith(
            status: updateMapStatus(source: state.status, keys: [
              CommentStatusKey.single.name,
            ], status: [
              Status.success,
            ]),
            comments: comments,
          ),
        );
      }
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.single.name,
          ], status: [
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(Exception("CommentBloc _deleteComment error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.single.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _getRelyComments(
      GetRelyCommentsEvent event, Emitter<CommentState> emit) async {
    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.rely.name,
        ], status: [
          Status.loading,
        ]),
        selectedCommentId: event.comment,
      ),
    );
    try {
      var relies = <Comment>[];
      var commentModels =
          await commentRepo.getReplyCommentsByCommentId(event.comment, token);
      for (var commentModel in commentModels) {
        var comment = await socialMapper.commentFromCommentModel(commentModel);
        relies.add(comment);
      }
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.rely.name,
          ], status: [
            Status.success,
          ]),
          relyComments: relies,
        ),
      );
    } on ResponseException catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.rely.name,
          ], status: [
            Status.error,
          ]),
          error: e,
        ),
      );

      addError(Exception("CommentBloc _getRelyComment error ${e.toString()}"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(source: state.status, keys: [
          CommentStatusKey.rely.name,
        ], status: [
          Status.idle,
        ]),
      ),
    );
  }

  FutureOr<void> _resetCommentsEvent(
      ResetCommentsEvent event, Emitter<CommentState> emit) {
    emit(CommentState(
      status: {
        CommentStatusKey.global.name: Status.idle,
      },
    ));
  }
}
