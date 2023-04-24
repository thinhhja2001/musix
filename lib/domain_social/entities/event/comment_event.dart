import 'package:musix/domain_social/entities/comment/comment.dart';

abstract class CommentEvent {
  const CommentEvent();
}

class GetCommentsEvent implements CommentEvent {
  final String postId;
  final List<Comment> comments;
  const GetCommentsEvent({
    required this.comments,
    required this.postId,
  });
}

class FilterCommentEvent implements CommentEvent {
  final bool turnOnFilter;
  const FilterCommentEvent(this.turnOnFilter);
}

class CreateCommentEvent implements CommentEvent {
  final String content;
  const CreateCommentEvent(this.content);
}

class EditCommentEvent implements CommentEvent {
  final String content;
  final String commentId;
  final bool isRely;
  const EditCommentEvent({
    required this.content,
    required this.commentId,
    this.isRely = false,
  });
}

class DeleteCommentEvent implements CommentEvent {
  final String commentId;
  final bool isRely;
  const DeleteCommentEvent(this.commentId, [this.isRely = false]);
}

class LikeCommentEvent implements CommentEvent {
  final String commentId;
  final bool isRely;
  const LikeCommentEvent(this.commentId, [this.isRely = false]);
}

class RelyCommentEvent implements CommentEvent {
  final String commentId;
  final String content;
  const RelyCommentEvent(this.commentId, this.content);
}

class GetRelyCommentsEvent implements CommentEvent {
  final String comment;
  const GetRelyCommentsEvent({
    required this.comment,
  });
}

class ResetCommentsEvent implements CommentEvent {}
