import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/domain_social/views/widgets/comments/rely_comment_widget.dart';
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
          CircleAvatar(
            radius: 12,
            backgroundImage: CachedNetworkImageProvider(
              comment.user?.profile?.avatarUrl ?? AssetPath.userUnknowImage,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${comment.user?.profile?.fullName ?? "Anonymous"} · ${convertMillisecondToDateString(comment.dateCreated ?? DateTime.now().millisecondsSinceEpoch)}",
                    style: TextStyleTheme.ts14
                        .copyWith(color: ColorTheme.white.withOpacity(.7)),
                  ),
                  Text(
                    "${comment.content}",
                    style: TextStyleTheme.ts14.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CommentBloc>()
                              .add(LikeCommentEvent(comment.id!, isRely));
                        },
                        child: BlocSelector<ProfileBloc, ProfileState, bool>(
                          selector: (state) {
                            try {
                              var user = comment.likedBy?.firstWhere(
                                  (element) => element.id == state.user?.id);
                              if (user != null) {
                                return true;
                              } else {
                                return false;
                              }
                            } on StateError {
                              return false;
                            }
                          },
                          builder: (context, isLiked) {
                            return Icon(
                              Icons.thumb_up_alt,
                              color: isLiked
                                  ? ColorTheme.primary
                                  : ColorTheme.white,
                              size: 12,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "${comment.likeCount ?? 0}",
                          style: TextStyleTheme.ts12
                              .copyWith(color: ColorTheme.white),
                        ),
                      ),
                      if (!isRely && isShowReply) ...[
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.comment_outlined,
                          size: 12,
                          color: ColorTheme.white,
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
                        style: TextStyleTheme.ts14
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
}
