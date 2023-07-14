import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/domain_social/views/widgets/comments/rely_comment_widget.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/utils/utils.dart';

import '../../../../theme/theme.dart';
import 'edit_comment_widget.dart';

class CommentCardWidget extends StatelessWidget {
  final Comment comment;
  final bool isRely;
  final bool isShowReply;
  const CommentCardWidget({
    super.key,
    required this.comment,
    this.isRely = false,
    this.isShowReply = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RoutingPath.profileSocial,
                arguments: comment.user),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: CachedNetworkImageProvider(
                comment.user?.profile?.avatarUrl ?? AssetPath.userUnknownImage,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${comment.user?.profile?.fullName ?? "Anonymous"} · ${convertMillisecondToDateString(comment.dateCreated ?? DateTime.now().millisecondsSinceEpoch)}",
                    style: TextStyleTheme.ts18
                        .copyWith(color: ColorTheme.white.withOpacity(.7)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${comment.content}",
                    style: TextStyleTheme.ts20.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return LikeButton(
                            isLiked: isLikedComment(
                                getUserLikedComment(), state.user!.username!),
                            onTap: (isLiked) async {
                              if (comment.likedBy == null) return false;
                              context
                                  .read<CommentBloc>()
                                  .add(LikeCommentEvent(comment.id!, isRely));
                              if (isLikedComment(getUserLikedComment(),
                                  state.user!.username!)) {
                                comment.likedBy!.removeWhere((user) =>
                                    user.username == state.user!.username);
                                return false;
                              } else {
                                comment.likedBy!.add(state.user!);
                              }
                              return true;
                            },
                            circleColor: const CircleColor(
                                start: ColorTheme.primary,
                                end: ColorTheme.primary),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor:
                                  ColorTheme.primary.withOpacity(.2),
                              dotSecondaryColor: ColorTheme.primary,
                            ),
                            likeBuilder: (_) {
                              if (comment.likedBy == null ||
                                  !comment.likedBy!.contains(state.user) ||
                                  comment.likedBy!.isEmpty) {
                                return const Icon(
                                  Icons.thumb_up_alt,
                                  color: Colors.white,
                                );
                              }
                              return const Icon(
                                Icons.thumb_up_alt,
                                color: ColorTheme.primary,
                              );
                            },
                            likeCount: comment.likeCount,
                            countBuilder: (likeCount, isLiked, text) => Text(
                              text,
                              style: TextStyleTheme.ts20
                                  .copyWith(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      if (!isRely && isShowReply) ...[
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CommentBloc>().add(
                                GetRelyCommentsEvent(comment: comment.id!));
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (context) => RelyCommentWidget(
                                      comment: comment,
                                    ));
                          },
                          child: const Icon(
                            Icons.comment_outlined,
                            size: 25,
                            color: ColorTheme.white,
                          ),
                        )
                      ],
                    ],
                  ),
                  if (!isRely &&
                      isShowReply &&
                      comment.replies?.isNotEmpty == true) ...[
                    TextButton(
                      onPressed: () {
                        context
                            .read<CommentBloc>()
                            .add(GetRelyCommentsEvent(comment: comment.id!));
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => RelyCommentWidget(
                                  comment: comment,
                                ));
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(
                          ColorTheme.primary.withOpacity(.2),
                        ),
                      ),
                      child: Text(
                        "${comment.replies?.length ?? 0} replies",
                        style: TextStyleTheme.ts20
                            .copyWith(color: ColorTheme.primary),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          BlocSelector<ProfileBloc, ProfileState, bool>(
            selector: (state) {
              return state.user?.id == comment.user?.id;
            },
            builder: (context, isOwner) {
              if (!isOwner) return const SizedBox.shrink();
              return PopupMenuButton(
                color: ColorTheme.background,
                offset: const Offset(-32, -8),
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  if (value == 0) {
                    showDialog(
                        context: context,
                        builder: (context) => EditCommentWidget(
                              comment: comment,
                              isReply: isRely,
                            ));
                  } else if (value == 1) {
                    context
                        .read<CommentBloc>()
                        .add(DeleteCommentEvent(comment.id!, isRely));
                  }
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      value: 0,
                      child: Center(
                        child: Text(
                          "Edit",
                          style: TextStyleTheme.ts14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text(
                          "Delete",
                          style: TextStyleTheme.ts14.copyWith(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ];
                },
              );
            },
          )
        ],
      ),
    );
  }

  List<String> getUserLikedComment() {
    List<String> usernames = List.empty(growable: true);
    for (var userLike in comment.likedBy!) {
      usernames.add(userLike.username!);
    }
    return usernames;
  }

  bool isLikedComment(List<String> usersLikedComment, String username) {
    return usersLikedComment.contains(username);
  }
}
