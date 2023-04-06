import 'package:get_it/get_it.dart';
import 'package:musix/config/exporter/repo_exporter.dart';
import 'package:musix/domain_social/entities/comment/comment.dart';
import 'package:musix/domain_social/logic/social_bloc.dart';
import 'package:musix/domain_social/models/post/post_model.dart';
import 'package:musix/domain_social/repository/comment/comment_repo.dart';
import 'package:musix/domain_user/entities/entities.dart';
import 'package:musix/domain_user/models/models.dart';
import 'package:musix/domain_user/utils/convert_model_entity.dart';

import '../../models/comment/comment_model.dart';
import '../post/post.dart';

class SocialMapper {
  final profileRepo = GetIt.I.get<ProfileRepo>();
  final commentRepo = GetIt.I.get<CommentRepo>();
  Future<List<Comment>> listCommentFromListCommentModel(
      List<CommentModel> commentModels) async {
    List<Comment> comments = List.empty(growable: true);
    for (var commentModel in commentModels) {
      Comment comment = await commentFromCommentModel(commentModel);
      comments.add(comment);
    }
    return comments;
  }

  Future<Comment> commentFromCommentModel(CommentModel commentModel) async {
    List<User> userLiked = List.empty(growable: true);
    List userLikedIds = commentModel.likedBy;
    ProfileResponseModel ownerUserModel =
        await profileRepo.getProfile(testToken, commentModel.ownerId);
    User owner = convertUserModelToUser(ownerUserModel.user!);
    for (var userId in userLikedIds) {
      ProfileResponseModel profileResponseModel =
          await profileRepo.getProfile(testToken, userId);

      User user = convertUserModelToUser(profileResponseModel.user!);
      userLiked.add(user);
    }
    return Comment(
        id: commentModel.id,
        author: commentModel.author,
        content: commentModel.content,
        dateCreated: commentModel.dateCreated,
        lastModified: commentModel.lastModified,
        likeCount: commentModel.likedBy.length,
        likedBy: userLiked,
        replies: List<String>.from(commentModel.replies),
        user: owner);
  }

  Future<Post> postFromPostModel(PostModel postModel) async {
    List<CommentModel> commentsModel =
        await commentRepo.getCommentsByPostId(postModel.id, testToken);
    List<Comment> comments =
        await listCommentFromListCommentModel(commentsModel);

    ProfileResponseModel ownerUserModel =
        await profileRepo.getProfile(testToken, postModel.ownerId);
    User owner = convertUserModelToUser(ownerUserModel.user!);

    List<User> userLiked = List.empty(growable: true);
    for (var userId in postModel.likedBy) {
      ProfileResponseModel profileResponseModel =
          await profileRepo.getProfile(testToken, userId);
      User user = convertUserModelToUser(profileResponseModel.user!);
      userLiked.add(user);
    }
    return Post(
        id: postModel.id,
        comments: comments,
        content: postModel.content,
        dateCreated: postModel.dateCreated,
        fileId: postModel.fileId,
        fileUrl: postModel.fileUrl,
        lastModified: postModel.lastModified,
        likedBy: userLiked,
        thumbnailId: postModel.thumbnailId,
        thumbnailUrl: postModel.thumbnailUrl,
        user: owner);
  }

  Future<List<Post>> listPostsFromListPostsModel(
      List<PostModel> postsModel) async {
    List<Post> posts = List.empty(growable: true);
    for (var postModel in postsModel) {
      Post post = await postFromPostModel(postModel);
      posts.add(post);
    }
    return posts;
  }
}
