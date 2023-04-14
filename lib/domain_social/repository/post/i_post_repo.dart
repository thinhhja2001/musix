import '../../models/post/request/post_registry_model.dart';

abstract class IPostRepo<T, E> {
  Future<E?> getPostById(String postId, String token);
  Future<List<E>> getAllPosts(String token);
  Future<List<E>> getPosts({
    int page = 0,
    int size = 5,
    required String token,
  });
  Future<List<E>> getPostsByUsername({
    required String username,
    int page = 0,
    int size = 5,
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
}
