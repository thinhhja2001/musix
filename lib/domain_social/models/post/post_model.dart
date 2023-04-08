class PostModel {
  PostModel({
    required this.id,
    required this.ownerId,
    required this.ownerUsername,
    required this.content,
    required this.fileId,
    required this.thumbnailId,
    required this.thumbnailUrl,
    required this.comments,
    required this.fileName,
    required this.dateCreated,
    required this.lastModified,
    required this.likedBy,
    required this.fileUrl,
  });

  String id;
  String ownerId;
  String ownerUsername;
  String content;
  String fileId;
  String thumbnailId;
  String thumbnailUrl;
  String fileName;
  List<String> comments;
  int dateCreated;
  int lastModified;
  List<String> likedBy;
  String fileUrl;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        ownerId: json["ownerId"],
        ownerUsername: json["ownerUsername"],
        fileName: json["fileName"],
        content: json["content"],
        fileId: json["fileId"],
        thumbnailId: json["thumbnailId"],
        thumbnailUrl: json["thumbnailUrl"],
        comments: List<String>.from(json["comments"].map((x) => x)),
        dateCreated: json["dateCreated"],
        lastModified: json["lastModified"],
        likedBy: List<String>.from(json["likedBy"].map((x) => x)),
        fileUrl: json["fileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerId": ownerId,
        "ownerUsername": ownerUsername,
        "content": content,
        "fileId": fileId,
        "fileName": fileName,
        "thumbnailId": thumbnailId,
        "thumbnailUrl": thumbnailUrl,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "dateCreated": dateCreated,
        "lastModified": lastModified,
        "likedBy": List<dynamic>.from(likedBy.map((x) => x)),
        "fileUrl": fileUrl,
      };
}
