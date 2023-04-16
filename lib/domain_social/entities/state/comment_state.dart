import 'package:equatable/equatable.dart';
import 'package:musix/utils/utils.dart';

import '../comment/comment.dart';

class CommentState extends Equatable {
  final Map<String, Status>? status;
  final String? postId;
  final List<Comment>? comments;
  final Comment? selectedComment;
  final bool? isFilter;
  final List<Comment>? oldComments;
  final ResponseException? error;

  const CommentState({
    this.status,
    this.postId,
    this.comments,
    this.selectedComment,
    this.isFilter,
    this.oldComments,
    this.error,
  });

  CommentState copyWith({
    Map<String, Status>? status,
    String? postId,
    List<Comment>? comments,
    Comment? selectedComment,
    bool? isFilter,
    List<Comment>? oldComments,
    ResponseException? error,
  }) {
    return CommentState(
      status: status ?? this.status,
      postId: postId ?? this.postId,
      comments: comments ?? this.comments,
      selectedComment: selectedComment ?? this.selectedComment,
      isFilter: isFilter ?? this.isFilter,
      oldComments: oldComments ?? this.oldComments,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        postId,
        comments?.length,
        selectedComment,
        isFilter,
      ];

  @override
  bool? get stringify => true;
}
