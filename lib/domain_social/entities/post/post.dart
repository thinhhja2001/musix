import 'package:equatable/equatable.dart';
import 'package:musix/domain_user/entities/entities.dart';

import '../comment/comment.dart';

class Post extends Equatable {
  final String? id;
  final User? user;
  final String? content;
  final String? fileId;
  final String? thumbnailId;
  final String? thumbnailUrl;
  final List<Comment>? comments;
  final int? dateCreated;
  final int? lastModified;
  final List<User>? likedBy;
  final String? fileUrl;
  const Post({
    this.id,
    this.user,
    this.content,
    this.fileId,
    this.thumbnailId,
    this.thumbnailUrl,
    this.comments,
    this.dateCreated,
    this.lastModified,
    this.likedBy,
    this.fileUrl,
  });
  Post copyWith({
    String? id,
    User? user,
    String? content,
    String? fileId,
    String? thumbnailId,
    String? thumbnailUrl,
    List<Comment>? comments,
    int? dateCreated,
    int? lastModified,
    List<User>? likedBy,
    String? fileUrl,
  }) =>
      Post(
        id: id ?? this.id,
        user: user ?? this.user,
        content: content ?? this.content,
        fileId: fileId ?? this.fileId,
        thumbnailId: thumbnailId ?? this.thumbnailId,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        comments: comments ?? this.comments,
        dateCreated: dateCreated ?? this.dateCreated,
        lastModified: lastModified ?? this.lastModified,
        likedBy: likedBy ?? this.likedBy,
        fileUrl: fileUrl ?? this.fileUrl,
      );
  @override
  List<Object?> get props => [
        id,
        user,
        content,
        fileId,
        thumbnailId,
        thumbnailUrl,
        comments,
        dateCreated,
        lastModified,
        likedBy,
        fileUrl,
      ];
  @override
  bool? get stringify => true;
}
