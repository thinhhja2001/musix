import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:musix/domain_social/entities/utils/social_mapper.dart';
import 'package:musix/domain_social/repository/post/post_repo.dart';

import '../../../../../domain_user/entities/profile/profile_state.dart';
import '../../../../../domain_user/logic/profile_bloc.dart';
import '../../../../../theme/color.dart';
import '../../../../entities/event/social_event.dart';
import '../../../../entities/post/post.dart';
import '../../../../logic/social_bloc.dart';

class LikeButtonWidget extends StatelessWidget {
  const LikeButtonWidget({
    super.key,
    required this.postId,
  });
  final String postId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return FutureBuilder<Post>(
            future: _getPost(postId),
            builder: (context, snapshot) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorTheme.white.withOpacity(.2),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: snapshot.hasData
                        ? LikeButton(
                            isLiked:
                                snapshot.data!.likedBy!.contains(state.user)
                                    ? true
                                    : false,
                            onTap: (isLiked) async {
                              if (snapshot.data!.likedBy == null) {
                                return false;
                              }
                              context
                                  .read<SocialBloc>()
                                  .add(SocialLikeOrDislikePostEvent(postId));
                              if (snapshot.data!.likedBy!
                                  .contains(state.user)) {
                                snapshot.data!.likedBy!.remove(state.user);
                                return false;
                              } else {
                                snapshot.data!.likedBy!.add(state.user!);
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
                              if (snapshot.data!.likedBy == null ||
                                  !snapshot.data!.likedBy!
                                      .contains(state.user) ||
                                  snapshot.data!.likedBy!.isEmpty) {
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
                            likeCount: snapshot.data!.likedBy?.length ?? 0,
                            countBuilder:
                                (int? count, bool isLiked, String text) {
                              var color = isLiked ? Colors.red : Colors.white;
                              Widget result;
                              result = Text(
                                text,
                                style: TextStyle(color: color),
                              );

                              return result;
                            })
                        : const _LikeButtonWithNoData()),
              );
            });
      },
    );
  }

  Future<Post> _getPost(String postId) async {
    final postModel = await PostRepo().getPostById(postId, testToken);
    final post = await SocialMapper().postFromPostModel(postModel!);
    return post;
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
