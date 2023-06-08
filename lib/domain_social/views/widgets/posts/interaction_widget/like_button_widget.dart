import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:musix/domain_auth/logic/auth_bloc.dart';
import 'package:musix/domain_social/views/widgets/posts/list_widget/user_liked_post_list_widget.dart';

import '../../../../../domain_user/entities/profile/profile_state.dart';
import '../../../../../domain_user/entities/user.dart';
import '../../../../../domain_user/logic/profile_bloc.dart';
import '../../../../../theme/color.dart';
import '../../../../entities/event/social_event.dart';
import '../../../../entities/post/post.dart';
import '../../../../entities/utils/social_mapper.dart';
import '../../../../logic/social_bloc.dart';
import '../../../../repository/post/post_repo.dart';

class LikeButtonWidget extends StatelessWidget {
  const LikeButtonWidget({
    super.key,
    required this.postId,
    this.isPostDetail = false,
  });
  final String postId;

  /// Whether it is being rendered in PostDetailScreen
  final bool isPostDetail;
  @override
  Widget build(BuildContext context) {
    Future<Post> getPost(String postId) async {
      final String token = context.read<AuthBloc>().state.jwtToken!;
      final postModel = await PostRepo().getPostById(postId, token);
      final post = await SocialMapper(token).postFromPostModel(postModel!);
      return post;
    }

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return FutureBuilder<Post>(
            future: getPost(postId),
            builder: (context, snapshot) {
              final post = snapshot.data;
              return Container(
                decoration: isPostDetail
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorTheme.white.withOpacity(.2),
                      ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: post != null
                        ? LikeButton(
                            isLiked: isLikedPost(
                                getUsernameLikedPost(post.likedBy!),
                                state.user!.username!),
                            onTap: (isLiked) async {
                              if (post.likedBy == null) {
                                return false;
                              }
                              context
                                  .read<SocialBloc>()
                                  .add(SocialLikeOrDislikePostEvent(postId));
                              if (isLikedPost(
                                  getUsernameLikedPost(post.likedBy!),
                                  state.user!.username!)) {
                                post.likedBy!.removeWhere((user) =>
                                    user.username == state.user!.username!);
                                return false;
                              } else {
                                post.likedBy!.add(state.user!);
                              }

                              return true;
                            },
                            circleColor: const CircleColor(
                                start: Colors.red, end: Colors.red),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Colors.red.shade200,
                              dotSecondaryColor: Colors.red,
                            ),
                            likeBuilder: (_) {
                              if (post.likedBy == null ||
                                  !post.likedBy!.contains(state.user) ||
                                  post.likedBy!.isEmpty) {
                                return const Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                );
                              }
                              return const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              );
                            },
                            likeCount: post.likedBy?.length ?? 0,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              var color = isLiked ? Colors.red : Colors.white;
                              Widget result;
                              if (isPostDetail && count != 0) {
                                result = Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              UserLikedPostListWidget(
                                                post: post,
                                              ));
                                    },
                                    child: Text(
                                      text,
                                      style: TextStyle(
                                          color: color,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                );
                              } else {
                                result = Text(
                                  text,
                                  style: TextStyle(color: color),
                                );
                              }

                              return result;
                            })
                        : const _LikeButtonWithNoData()),
              );
            });
      },
    );
  }

  List<String> getUsernameLikedPost(List<User> users) {
    List<String> usernames = List.empty(growable: true);
    for (var user in users) {
      usernames.add(user.username!);
    }
    return usernames;
  }

  bool isLikedPost(List<String> usersLikedPost, String username) {
    return usersLikedPost.contains(username);
  }
}

class _LikeButtonWithNoData extends StatelessWidget {
  const _LikeButtonWithNoData();

  @override
  Widget build(BuildContext context) {
    return LikeButton(
        circleColor: const CircleColor(start: Colors.red, end: Colors.red),
        bubblesColor: BubblesColor(
          dotPrimaryColor: Colors.red.shade200,
          dotSecondaryColor: Colors.red,
        ),
        likeBuilder: (_) {
          return const Icon(
            Icons.favorite_outline,
            color: Colors.white,
          );
        },
        likeCount: 0,
        countBuilder: (int? count, bool isLiked, String text) {
          return const Text(
            '0',
            style: TextStyle(color: Colors.white),
          );
        });
  }
}
