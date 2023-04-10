import 'package:musix/domain_social/entities/comment/comment.dart';

abstract class CommentEvent {
  const CommentEvent();
}

class GetCommentsEvent implements CommentEvent {
  final List<Comment> comments;
  const GetCommentsEvent(this.comments);
}

class FilterCommentEvent implements CommentEvent {
  final bool turnOnFilter;
  const FilterCommentEvent(this.turnOnFilter);
}
