import '../../models/post/request/post_registry_model.dart';

abstract class IPostRepo<T, E> {
  Future<E?> getPostById(String postId, String token);
  Future<List<E>> getAllPosts(String token);
  Future<List<E>> getPosts({
    required int page,
    required int size,
    required String token,
  });
  Future<List<E>> getPostsByUsername({
    required String username,
    required int page,
    required int size,
    required String token,
  });
  Future<List<E>> getPostsByQuery({
    required String query,
    required int page,
    required int size,
    required String token,
  });
  Future<T> createNewPost(PostRegistryModel postRegistryModel, String token);
  Future<T> modifyPost({
    required String postId,
    required PostRegistryModel postRegistryModel,
    required String token,
  });
  Future<T> likeOrDislikePost(String postId, String token);
  Future<T> deletePost(String postId, String token);
  Future<List<E>> getFollowingPost(String token);
}
