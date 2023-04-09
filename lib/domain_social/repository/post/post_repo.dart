import 'dart:io';

import 'package:dio/dio.dart';
import 'package:musix/domain_auth/utils/dio_utils.dart';
import 'package:musix/domain_social/models/comment/request/create_comment_request.dart';
import 'package:musix/domain_social/models/post/post_model.dart';
import 'package:musix/domain_social/models/post/request/post_registry_model.dart';
import 'package:musix/domain_social/models/post/response/post_response_model.dart';
import 'package:musix/domain_social/repository/post/i_post_repo.dart';
import 'package:musix/global/repo/initial_repo.dart';

class PostRepo extends InitialRepo
    implements IPostRepo<PostResponseModel, PostModel> {
  final _baseUrl = "/social/post";
  @override
  Future<PostResponseModel> addComment({
    required String postId,
    required CreateCommentModel createCommentModel,
    required String token,
  }) async {
    var response = await dio.post(
      "$_baseUrl/comment/$postId",
      data: createCommentModel.toJson(),
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return PostResponseModel.fromJson(response.data);
  }

  @override
  Future<PostResponseModel> deleteComment({
    required String postId,
    required String commentId,
    required String token,
  }) async {
    var response = await dio.delete(
      "$_baseUrl/comment/delete",
      data: {
        "postId": postId,
        "commentId": commentId,
      },
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return PostResponseModel.fromJson(response.data);
  }

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
  Future<List<PostModel>> getPostsByUsername(
      String username, String token) async {
    var response = await dio.get(_baseUrl,
        queryParameters: {
          "username": username,
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
    var response = await dio.put("$_baseUrl/$postId",
        options: Options(headers: headerApplicationJson(token: token)));
    return PostResponseModel.fromJson(response.data);
  }

  @override
  Future<PostResponseModel> createNewPost(
      PostRegistryModel postRegistryModel, String token) async {
    if (postRegistryModel.file != null && postRegistryModel.thumbnail != null) {
      print("all condition is true");
    }
    if (postRegistryModel.file == null) {
      print("file is null");
    }
    if (postRegistryModel.thumbnail == null) {
      print("thumbnail is null");
    }
    print('file path ${postRegistryModel.file!.path}');
    var data = FormData.fromMap({
      "content": postRegistryModel.content,
      "fileName": postRegistryModel.name,
      "file": MultipartFile.fromFileSync(postRegistryModel.file!.path),
      "thumbnail": MultipartFile.fromFileSync(postRegistryModel.thumbnail!.path)
    });
    print("data is $data");
    try {
      final response = await dio.post(
        _baseUrl,
        data: data,
        options: Options(
          headers: headerMultiFormData(token: token),
        ),
      );
      print("statusCode ${response.statusCode}");
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
}
