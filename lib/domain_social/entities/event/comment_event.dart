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
  const EditCommentEvent({
    required this.content,
    required this.commentId,
  });
}

class DeleteCommentEvent implements CommentEvent {
  final String commentId;
  const DeleteCommentEvent(this.commentId);
}

class LikeCommentEvent implements CommentEvent {
  final String commentId;
  const LikeCommentEvent(this.commentId);
}

class RelyCommentEvent implements CommentEvent {
  final String commentId;
  final String content;
  const RelyCommentEvent(this.commentId, this.content);
}
