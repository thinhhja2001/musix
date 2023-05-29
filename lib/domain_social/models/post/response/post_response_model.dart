// Post or posts should be null
class PostResponseModel {
  PostResponseModel({
    required this.status,
    required this.msg,
  });

  int status;
  String msg;

  factory PostResponseModel.fromJson(Map<String, dynamic> json) =>
      PostResponseModel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
