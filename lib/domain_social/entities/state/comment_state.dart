import 'package:equatable/equatable.dart';
import 'package:musix/utils/utils.dart';

import '../comment/comment.dart';

class CommentState extends Equatable {
  final Map<String, Status>? status;
  final List<Comment>? comments;
  final Comment? selectedComment;
  final bool? isFilter;
  final List<Comment>? oldComments;

  const CommentState({
    this.status,
    this.comments,
    this.selectedComment,
    this.isFilter,
    this.oldComments,
  });

  CommentState copyWith({
    Map<String, Status>? status,
    List<Comment>? comments,
    Comment? selectedComment,
    bool? isFilter,
    List<Comment>? oldComments,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      selectedComment: selectedComment ?? this.selectedComment,
      isFilter: isFilter ?? this.isFilter,
      oldComments: oldComments ?? this.oldComments,
    );
  }

  @override
  List<Object?> get props => [
        status,
        comments?.length,
        selectedComment,
        isFilter,
      ];

  @override
  bool? get stringify => true;
}
