import 'package:equatable/equatable.dart';
import 'package:musix/utils/utils.dart';

import '../comment/comment.dart';

class CommentState extends Equatable {
  final Map<String, Status>? status;
  final String? postId;
  final List<Comment>? comments;
  final String? selectedCommentId;
  final bool? isFilter;
  final List<Comment>? relyComments;
  final ResponseException? error;

  const CommentState({
    this.status,
    this.postId,
    this.comments,
    this.selectedCommentId,
    this.isFilter,
    this.relyComments,
    this.error,
  });

  CommentState copyWith({
    Map<String, Status>? status,
    String? postId,
    List<Comment>? comments,
    String? selectedCommentId,
    bool? isFilter,
    List<Comment>? relyComments,
    ResponseException? error,
  }) {
    return CommentState(
      status: status ?? this.status,
      postId: postId ?? this.postId,
      comments: comments ?? this.comments,
      selectedCommentId: selectedCommentId ?? this.selectedCommentId,
      relyComments: relyComments ?? this.relyComments,
      isFilter: isFilter ?? this.isFilter,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        postId,
        comments?.length,
        relyComments?.length,
        selectedCommentId,
        isFilter,
      ];

  @override
  bool? get stringify => true;
}
