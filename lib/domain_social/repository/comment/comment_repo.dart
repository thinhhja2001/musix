import 'package:dio/dio.dart';
import '../../models/comment/comment_model.dart';
import '../../models/comment/request/modify_comment_request.dart';
import '../../models/comment/request/create_comment_request.dart';
import '../../models/comment/response/comment_response_model.dart';
import 'i_comment_repo.dart';
import '../../../global/repo/initial_repo.dart';

class CommentRepo extends InitialRepo
    implements ICommentRepo<CommentResponseModel, CommentModel> {
  final _baseUrl = "/social/comment";
  @override
  Future<CommentModel?> getComment(String commentId, String token) async {
    var response = await dio.get(
      "$_baseUrl/$commentId",
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    if (response.statusCode != 200) {
      return null;
    }
    return CommentModel.fromJson(response.data['data']['comment']);
  }

  @override
  Future<CommentResponseModel> createComment(
      CreateCommentModel createCommentModel, String token) async {
    var response = await dio.post(
      _baseUrl,
      data: createCommentModel.toJson(),
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return CommentResponseModel.fromJson(response.data);
  }

  @override
  Future<CommentResponseModel> deleteComment(
      String commentId, String token) async {
    var response = await dio.delete(
      "$_baseUrl/$commentId",
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return CommentResponseModel.fromJson(response.data);
  }

  @override
  Future<CommentResponseModel> likeOrDislikeComment(
      String commentId, String token) async {
    var response = await dio.put(
      "$_baseUrl/like/$commentId",
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return CommentResponseModel.fromJson(response.data);
  }

  @override
  Future<CommentResponseModel> modifyComment(
      ModifyCommentModel modifyCommentModel, String token) async {
    var response = await dio.put(
      _baseUrl,
      data: modifyCommentModel.toJson(),
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return CommentResponseModel.fromJson(response.data);
  }

  @override
  Future<CommentResponseModel> replyComment(String commentId,
      CreateCommentModel createCommentModel, String token) async {
    var response = await dio.post(
      "$_baseUrl/reply/$commentId",
      data: createCommentModel.toJson(),
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );
    return CommentResponseModel.fromJson(response.data);
  }

  @override
  Future<List<CommentModel>> getCommentsByPostId(
      String postId, String token) async {
    var response = await dio.post("$_baseUrl/post/$postId",
        options: Options(headers: headerApplicationJson(token: token)));
    if (response.statusCode != 200) return List<CommentModel>.empty();
    return List<CommentModel>.from(response.data['data']['comments']
        .map((comment) => CommentModel.fromJson(comment)));
  }
}
