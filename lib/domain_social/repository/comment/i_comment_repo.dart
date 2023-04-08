import '../../models/comment/request/create_comment_request.dart';
import '../../models/comment/request/modify_comment_request.dart';

abstract class ICommentRepo<T, E> {
  Future<E?> getComment(String commentId, String token);
  Future<List<E>> getCommentsByPostId(String postId, String token);
  Future<T> createComment(CreateCommentModel createCommentModel, String token);
  Future<T> likeOrDislikeComment(String commentId, String token);
  Future<T> modifyComment(ModifyCommentModel modifyCommentModel, String token);
  Future<T> replyComment(
      String commentId, CreateCommentModel createCommentModel, String token);
  Future<T> deleteComment(String commentId, String token);
}
