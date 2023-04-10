import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/utils/utils.dart';

import '../../config/exporter.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc({
    required CommentState initialState,
    required this.commentRepo,
  }) : super(initialState) {
    on<GetCommentsEvent>(_getComments);
    on<FilterCommentEvent>(_filterComments);
  }

  final CommentRepo commentRepo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  FutureOr<void> _getComments(
      GetCommentsEvent event, Emitter<CommentState> emit) async {
    emit(state.copyWith(comments: event.comments));
  }

  FutureOr<void> _filterComments(
      FilterCommentEvent event, Emitter<CommentState> emit) async {
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
      var oldComments = state.comments;
      state.comments
          ?.sort((a, b) => (a.dateCreated ?? 0).compareTo(b.dateCreated ?? 0));

      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.global.name,
          ], status: [
            Status.success,
          ]),
          oldComments: oldComments,
          comments: state.comments,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: updateMapStatus(source: state.status, keys: [
            CommentStatusKey.global.name,
          ], status: [
            Status.success,
          ]),
          oldComments: state.comments,
          comments: state.oldComments,
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
}
