import 'package:dio/dio.dart';
import 'package:musix/domain_social/models/comment/comment_model.dart';
import 'package:musix/domain_social/models/comment/request/create_comment_request.dart';
import 'package:musix/domain_social/models/comment/request/modify_comment_request.dart';
import 'package:musix/domain_social/repository/comment/i_comment_repo.dart';
import 'package:musix/global/repo/initial_repo.dart';

import '../../../utils/utils.dart';

class CommentRepo extends InitialRepo
    implements ICommentRepo<bool, CommentModel> {
  final _baseUrl = "/social/comment";
  @override
  Future<CommentModel> getComment(String commentId, String token) async {
    try {
      var response = await dio.get(
        "$_baseUrl/$commentId",
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return CommentModel.fromJson(response.data['data']['comment']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  @override
  Future<CommentModel> createComment(
      CreateCommentModel createCommentModel, String token) async {
    try {
      var response = await dio.post(
        _baseUrl,
        data: createCommentModel.toJson(),
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return CommentModel.fromJson(response.data['data']['comment']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  @override
  Future<bool> deleteComment(String commentId, String token) async {
    try {
      await dio.delete(
        "$_baseUrl/$commentId",
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return true;
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  @override
  Future<CommentModel> likeOrDislikeComment(
      String commentId, String token) async {
    try {
      var response = await dio.put(
        "$_baseUrl/like/$commentId",
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return CommentModel.fromJson(response.data['data']['comment']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  @override
  Future<CommentModel> modifyComment(
      ModifyCommentModel modifyCommentModel, String token) async {
    try {
      var response = await dio.put(
        _baseUrl,
        data: modifyCommentModel.toJson(),
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return CommentModel.fromJson(response.data['data']['comment']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  @override
  Future<CommentModel> replyComment(String commentId,
      CreateCommentModel createCommentModel, String token) async {
    try {
      var response = await dio.post(
        "$_baseUrl/reply/$commentId",
        data: createCommentModel.toJson(),
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return CommentModel.fromJson(response.data['data']['comment']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(
      String postId, String token) async {
    try {
      var response = await dio.get("$_baseUrl/post/$postId",
          options: Options(headers: headerApplicationJson(token: token)));
      if (response.statusCode != 200) return List<CommentModel>.empty();
      return List<CommentModel>.from(response.data['data']['comments']
          .map((comment) => CommentModel.fromJson(comment)));
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }
}
