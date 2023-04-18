class CreateCommentModel {
  String? postId;
  String? content;

  CreateCommentModel({
    this.postId,
    this.content,
  });

  CreateCommentModel.fromJson(dynamic json) {
    postId = json['postId'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postId'] = postId;
    map['content'] = content;
    return map;
  }
}
