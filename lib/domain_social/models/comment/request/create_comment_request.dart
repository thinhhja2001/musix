class CreateCommentModel {
  String content;
  CreateCommentModel({
    required this.content,
  });

  CreateCommentModel copyWith({
    String? content,
  }) {
    return CreateCommentModel(
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
    };
  }

  factory CreateCommentModel.fromJson(Map<String, dynamic> map) {
    return CreateCommentModel(
      content: map['content'] as String,
    );
  }
}
