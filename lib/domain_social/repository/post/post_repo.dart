import 'package:dio/dio.dart';

import '../../../global/repo/initial_repo.dart';
import '../../models/post/post_model.dart';
import '../../models/post/request/post_registry_model.dart';
import '../../models/post/response/post_response_model.dart';
import 'i_post_repo.dart';

class PostRepo extends InitialRepo
    implements IPostRepo<PostResponseModel, PostModel> {
  final _baseUrl = "/social/post";

  @override
  Future<PostResponseModel> deletePost(String postId, String token) async {
    var response = await dio.delete(
      "$_baseUrl/$postId",
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return PostResponseModel.fromJson(response.data);
  }

  @override
  Future<PostModel?> getPostById(String postId, String token) async {
    var response = await dio.get("$_baseUrl/$postId",
        options: Options(headers: headerApplicationJson(token: token)));
    if (response.statusCode != 200) return null;

    return PostModel.fromJson(response.data['data']['post']);
  }

  @override
  Future<List<PostModel>> getPostsByUsername({
    required String username,
    required int page,
    required int size,
    required String token,
  }) async {
    var response = await dio.get(_baseUrl,
        queryParameters: {
          "username": username,
          "page": page,
          "size": size,
        },
        options: Options(headers: headerApplicationJson(token: token)));
    if (response.statusCode != 200) return List<PostModel>.empty();
    return List<PostModel>.from(
      response.data['data']['posts'].map(
        (post) => PostModel.fromJson(post),
      ),
    );
  }

  @override
  Future<List<PostModel>> getPostsByQuery({
    required String query,
    required int page,
    required int size,
    required String token,
  }) async {
    var response = await dio.get("$_baseUrl/by-content",
        queryParameters: {
          "query": query,
          "page": page,
          "size": size,
        },
        options: Options(headers: headerApplicationJson(token: token)));
    if (response.statusCode != 200) return List<PostModel>.empty();
    return List<PostModel>.from(
      response.data['data']['posts'].map(
        (post) => PostModel.fromJson(post),
      ),
    );
  }

  @override
  Future<PostResponseModel> likeOrDislikePost(
      String postId, String token) async {
    var response = await dio.put("$_baseUrl/like/$postId",
        options: Options(headers: headerApplicationJson(token: token)));
    return PostResponseModel.fromJson(response.data);
  }

  @override
  Future<PostResponseModel> createNewPost(
      PostRegistryModel postRegistryModel, String token) async {
    var data = FormData.fromMap({
      "content": postRegistryModel.content,
      "fileName": postRegistryModel.name,
      "file": MultipartFile.fromFileSync(postRegistryModel.file!.path),
      "thumbnail": MultipartFile.fromFileSync(postRegistryModel.thumbnail!.path)
    });
    try {
      final response = await dio.post(
        _baseUrl,
        data: data,
        options: Options(
          headers: headerMultiFormData(token: token),
        ),
      );
      return PostResponseModel.fromJson(response.data);
    } catch (e, s) {
      print("Exception is ${e.toString()}");
      return PostResponseModel(status: 404, msg: 'error');
    }
  }

  @override
  Future<PostResponseModel> modifyPost({
    required String postId,
    required PostRegistryModel postRegistryModel,
    required String token,
  }) async {
    var data = FormData.fromMap({
      "content": postRegistryModel.content,
      "file": postRegistryModel.file != null
          ? MultipartFile.fromFileSync(postRegistryModel.file!.path)
          : null,
      "fileName": postRegistryModel.name,
      "thumbnail": postRegistryModel.thumbnail != null
          ? MultipartFile.fromFileSync(postRegistryModel.thumbnail!.path)
          : null
    });
    var response = await dio.put(
      "$_baseUrl/$postId",
      data: data,
      options: Options(
        headers: headerMultiFormData(token: token),
      ),
    );
    return PostResponseModel.fromJson(response.data);
  }

  @override
  Future<List<PostModel>> getAllPosts(String token) async {
    var response = await dio.get("$_baseUrl/all",
        options: Options(headers: headerApplicationJson(token: token)));
    if (response.statusCode != 200) return List<PostModel>.empty();
    return List<PostModel>.from(
        response.data['data']['posts'].map((post) => PostModel.fromJson(post)));
  }

  @override
  Future<List<PostModel>> getPosts({
    required int page,
    required int size,
    required String token,
  }) async {
    var response = await dio.get("$_baseUrl/posts",
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
        queryParameters: {
          "page": page,
          "size": size,
        });
    if (response.statusCode != 200) {
      return List.empty();
    }
    return List<PostModel>.from(
      response.data['data']['posts'].map(
        (post) => PostModel.fromJson(post),
      ),
    );
  }

  @override
  Future<List<PostModel>> getFollowingPost(String token) async {
    var response = await dio.get(
      "$_baseUrl/following",
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    if (response.statusCode != 200) {
      return List.empty();
    }
    return List<PostModel>.from(
      response.data['data']['posts'].map(
        (post) => PostModel.fromJson(post),
      ),
    );
  }
}
