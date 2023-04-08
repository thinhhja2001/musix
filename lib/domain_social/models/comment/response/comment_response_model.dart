class CommentResponseModel {
  int status;
  String msg;
  CommentResponseModel({required this.status, required this.msg});

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentResponseModel(
        status: json['status'],
        msg: json['msg'],
      );
  Map<String, dynamic> toJson() => {"status": status, "msg": msg};
}
