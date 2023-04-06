import 'package:musix/domain_social/models/comment/request/create_comment_request.dart';
import 'package:musix/domain_social/models/post/request/post_registry_model.dart';

abstract class IPostRepo<T, E> {
  Future<E?> getPostById(String postId, String token);
  Future<List<E>> getAllPosts(String token);
  Future<List<E>> getPostsByUsername(String username, String token);
  Future<T> createNewPost(PostRegistryModel postRegistryModel, String token);
  Future<T> modifyPost({
    required String postId,
    required PostRegistryModel postRegistryModel,
    required String token,
  });
  Future<T> likeOrDislikePost(String postId, String token);
  Future<T> addComment({
    required String postId,
    required CreateCommentModel createCommentModel,
    required String token,
  });
  Future<T> deleteComment({
    required String postId,
    required String commentId,
    required String token,
  });
  Future<T> deletePost(String postId, String token);
}
