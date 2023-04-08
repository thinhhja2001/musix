class ModifyCommentModel {
  String commentId;
  String newContent;
  ModifyCommentModel({
    required this.commentId,
    required this.newContent,
  });

  ModifyCommentModel copyWith({
    String? commentId,
    String? newContent,
  }) {
    return ModifyCommentModel(
      commentId: commentId ?? this.commentId,
      newContent: newContent ?? this.newContent,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'commentId': commentId,
      'newContent': newContent,
    };
  }

  factory ModifyCommentModel.fromJson(Map<String, dynamic> map) {
    return ModifyCommentModel(
      commentId: map['commentId'] as String,
      newContent: map['newContent'] as String,
    );
  }
}
