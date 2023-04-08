class CommentModel {
  CommentModel({
    required this.id,
    required this.ownerId,
    required this.ownerUsername,
    required this.replies,
    required this.likedBy,
    required this.dateCreated,
    required this.content,
    required this.lastModified,
    required this.author,
  });

  String id;
  String ownerId;
  String ownerUsername;
  List<dynamic> replies;
  List<dynamic> likedBy;
  int dateCreated;
  String content;
  int lastModified;
  bool author;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        ownerId: json["ownerId"],
        ownerUsername: json["ownerUsername"],
        replies: List<dynamic>.from(json["replies"].map((x) => x)),
        likedBy: List<dynamic>.from(json["likedBy"].map((x) => x)),
        dateCreated: json["dateCreated"],
        content: json["content"],
        lastModified: json["lastModified"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerId": ownerId,
        "ownerUsername": ownerUsername,
        "replies": List<dynamic>.from(replies.map((x) => x)),
        "likedBy": List<dynamic>.from(likedBy.map((x) => x)),
        "dateCreated": dateCreated,
        "content": content,
        "lastModified": lastModified,
        "author": author,
      };
}
