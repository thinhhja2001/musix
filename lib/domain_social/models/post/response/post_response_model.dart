// Post or posts should be null
import 'package:musix/domain_social/models/post/post_model.dart';

class PostResponseModel {
  PostResponseModel({
    required this.status,
    required this.msg,
    this.post,
  });

  int status;
  String msg;
  PostModel? post;
  factory PostResponseModel.fromJson(Map<String, dynamic> json) =>
      PostResponseModel(
          status: json["status"],
          msg: json["msg"],
          post: json["status"] == 200
              ? PostModel.fromJson(json["data"]["post"])
              : null);

  Map<String, dynamic> toJson() =>
      {"status": status, "msg": msg, "post": post?.toJson()};
}
