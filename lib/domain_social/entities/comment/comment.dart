import 'package:equatable/equatable.dart';
import '../../../domain_user/entities/entities.dart';

class Comment extends Equatable {
  final String? id;
  final User? user;
  final List<String>? replies;
  final List<User>? likedBy;
  final int? likeCount;
  final int? dateCreated;
  final String? content;
  final int? lastModified;
  final bool? author;

  const Comment({
    this.id,
    this.user,
    this.replies,
    this.likedBy,
    this.likeCount,
    this.dateCreated,
    this.content,
    this.lastModified,
    this.author,
  });
  Comment copyWith({
    String? id,
    User? user,
    List<String>? replies,
    List<User>? likedBy,
    int? likeCount,
    int? dateCreated,
    String? content,
    int? lastModified,
    bool? author,
  }) =>
      Comment(
          id: id ?? this.id,
          user: user ?? this.user,
          replies: replies ?? this.replies,
          likedBy: likedBy ?? this.likedBy,
          author: author ?? this.author,
          content: content ?? this.content,
          dateCreated: dateCreated ?? this.dateCreated,
          lastModified: lastModified ?? this.lastModified,
          likeCount: likeCount ?? this.likeCount);
  @override
  List<Object?> get props => [
        id,
        user,
        replies?.length,
        likeCount,
        likedBy?.length,
        dateCreated,
        content,
        lastModified,
        author,
      ];

  @override
  bool? get stringify => true;
}
